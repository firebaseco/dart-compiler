module Dart

  VERSION           = "0.0.1"

  COMPILER_VERSION  = "20111013"

  JAVA_COMMAND      = 'java'

  COMPILER_ROOT     = File.expand_path(File.dirname(__FILE__))

  COMPILER_JAR_PATH = File.join(COMPILER_ROOT, "java")

end

require 'dart/compiler'
