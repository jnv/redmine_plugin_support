require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "redmine_plugin_support"
    gem.summary = %Q{Libraries to automate the creation and management of Redmine plugins}
    gem.description = %Q{This libarary is a collection of rake tasks and other scripts that will make Redmine plugin development easier.}
    gem.email = "edavis@littlestreamsoftware.com"
    gem.homepage = "http://github.com/edavis10/redmine_plugin_support"
    gem.authors = ["Eric Davis"]
    gem.add_development_dependency "thoughtbot-shoulda"
    gem.rubyforge_project = "redmine_plugin_support" # TODO
    gem.files =  FileList[
                          "[A-Z]*",
                          "init.rb",
                          "rails/init.rb",
                          "{bin,generators,lib,test,app,assets,config,lang}/**/*",
                          'lib/jeweler/templates/.gitignore'
                         ]

    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
  Jeweler::RubyforgeTasks.new do |rubyforge|
    rubyforge.doc_task = "rdoc"
  end

rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/*_test.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

begin
  require 'reek/rake_task'
  Reek::RakeTask.new do |t|
    t.fail_on_error = true
    t.verbose = false
    t.source_files = 'lib/**/*.rb'
  end
rescue LoadError
  task :reek do
    abort "Reek is not available. In order to run reek, you must: sudo gem install reek"
  end
end

begin
  require 'roodi'
  require 'roodi_task'
  RoodiTask.new do |t|
    t.verbose = false
  end
rescue LoadError
  task :roodi do
    abort "Roodi is not available. In order to run roodi, you must: sudo gem install roodi"
  end
end

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION')
    version = File.read('VERSION')
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "redmine_plugin_support #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
