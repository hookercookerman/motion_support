#!/usr/bin/env rake
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'
require "bundler/gem_tasks"
Bundler.setup
Bundler.require
require 'bubble-wrap/test'

require "motion_support"
require "motion_support/all"

# Bug RubyMotion 1.15
Motion::Project::App.setup do |app|
  app.redgreen_style = :full
  spec_files = app.spec_files + Dir.glob(File.join(app.specs_dir, '**', '*.rb'))
  app.instance_variable_set("@spec_files", spec_files.uniq!)
end
