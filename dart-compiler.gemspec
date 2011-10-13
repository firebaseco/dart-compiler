Gem::Specification.new do |s|
  s.name      = 'dart-compiler'
  s.version   = '0.0.1'            # Keep version in sync with dart-compiler.rb
  s.date      = '2011-10-13'

  s.homepage    = "http://github.com/guilleiguaran/dart-compiler/"
  s.summary     = "Ruby Wrapper for the Dart Compiler"
  s.description = <<-EOS
    A Ruby Wrapper for the Dart Compiler.
  EOS

  s.authors           = ['Guillermo Iguaran']
  s.email             = 'guilleiguaran@gmail.com'

  s.require_paths     = ['lib']

  s.rdoc_options      << '--title'    << 'Ruby Dart Compiler' <<
                         '--all'

  s.files = Dir['lib/**/*', 'dart-compiler.gemspec', 'README.textile', 'LICENSE', 'COPYING']

end
