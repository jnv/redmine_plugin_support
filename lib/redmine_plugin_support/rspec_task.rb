gem 'rspec'
gem 'rspec-rails'
require "rspec/core/rake_task"

module RedminePluginSupport
  class RspecTask < GeneralTask
    def define

      desc "Run all specs in spec directory (excluding plugin specs)"
      RSpec::Core::RakeTask.new(:spec) do |task|
        task.rspec_opts = ['--options', "\"#{RedmineHelper.plugin_root}/spec/spec.opts\""]
        task.pattern = 'spec/**/*_spec.rb'
      end
      
      namespace :spec do
        desc "Run all specs in spec directory with RCov (excluding plugin specs)"
        RSpec::Core::RakeTask.new(:rcov) do |task|
          task.rspec_opts = ['--options', "\"#{RedmineHelper.plugin_root}/spec/spec.opts\""]
          task.pattern = 'spec/**/*_spec.rb'
          #task.rcov = true
          #task.rcov_opts << ["--rails", "--sort=coverage", "--exclude '/var/lib/gems,spec,#{RedmineHelper.redmine_app},#{RedmineHelper.redmine_lib}'"]
        end
        
        desc "Print Specdoc for all specs (excluding plugin specs)"
        RSpec::Core::RakeTask.new(:doc) do |task|
          task.rspec_opts = ["--format", "specdoc", "--dry-run"]
          task.pattern = 'spec/**/*_spec.rb'
        end

        desc "Print Specdoc for all specs as HTML (excluding plugin specs)"
        RSpec::Core::RakeTask.new(:htmldoc) do |task|
          task.rspec_opts = ["--format", "html:doc/rspec_report.html", "mtime"]
          task.pattern = 'spec/**/*_spec.rb'
        end

        [:models, :controllers, :views, :helpers, :lib].each do |sub|
          desc "Run the specs under spec/#{sub}"
          RSpec::Core::RakeTask.new(sub) do |task|
            task.pattern = "spec/#{sub}/**/*_spec.rb"
          end
        end

      end
      self
    end    
  end
end
