require 'bubble-wrap/loader'

Dir["#{File.dirname(__FILE__)}/inflector/*.rb"].sort.each do |path|
  require path
end

#BubbleWrap.require "motion/inflections.rb"

