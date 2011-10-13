namespace :gem do

  desc 'Build and install the dart-compiler gem'
  task :install do
    sh "gem build dart-compiler.gemspec"
    sh "sudo gem install #{Dir['*.gem'].join(' ')} --local --no-ri --no-rdoc"
  end

  desc 'Uninstall the dart-compiler gem'
  task :uninstall do
    sh "sudo gem uninstall -x dart-compiler"
  end

end
