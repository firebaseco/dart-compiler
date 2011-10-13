require 'stringio'
require 'tempfile'

module Dart

  # We raise a Dart::Error when compilation fails for any reason.
  class Error < StandardError; end

  # The Dart::Compiler is a basic wrapper around the Dart Compiler. There's not
  # much to see here.
  class Compiler

    DEFAULT_OPTIONS = {:work => Dir.tmpdir, :out => "#{Dir.tmpdir}/output.js",
                       :optimize => nil}

    # When you create a Compiler, pass in the flags and options.
    def initialize(options={})
      @java     = options.delete(:java)     || JAVA_COMMAND
      @jar_path = options.delete(:jar_path) || COMPILER_JAR_PATH
      @out      = options[:out]             || DEFAULT_OPTIONS[:out]
      @options  = serialize_options(DEFAULT_OPTIONS.merge(options))
    end

    # Can compile a Dart string or open IO object.
    # Returns the compiled JavaScript as a string.
    def compile(io)
      tempfile = Tempfile.new('dart_compiler')
      if io.respond_to? :read
        while buffer = io.read(4096) do
          tempfile.write(buffer)
        end
      else
        tempfile.write(io.to_s)
      end
      tempfile.flush

      begin
        result = `#{command} #{tempfile.path} 2>&1`
      rescue Exception
        raise Error, "compression failed: #{result}"
      ensure
        tempfile.close!
      end
      unless $?.exitstatus.zero?
        raise Error, result
      end
      output = File.open(@out).read
    end

    private

    # Serialize hash options to the command-line format.
    def serialize_options(options)
      options.map do |k, v|
        if (v.is_a?(Array))
          v.map {|v2| ["--#{k}", v2.to_s]}
        else
          ["--#{k}", v.to_s]
        end
      end.flatten
    end

    def command
      [@java, '-classpath', "\"#{@jar_path}/*\"",
       'com.google.dart.compiler.DartCompiler', @options].flatten.join(' ')
    end

  end
end
