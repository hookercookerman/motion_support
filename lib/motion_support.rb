unless defined?(Motion::Project::Config)
  raise "This file must be required within a RubyMotion project Rakefile."
end

require "motion_support/version" unless defined?(MotionSupport::VERSION)
