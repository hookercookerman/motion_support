unless defined?(Motion::Project::Config)
  raise "This file must be required within a RubyMotion project Rakefile."
end

require "motion_support/version"

require File.expand_path('../motion_support/all', __FILE__)
