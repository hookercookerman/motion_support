require 'bubble-wrap/loader'
Dir["#{File.dirname(__FILE__)}/inflector/*.rb"].sort.each do |path|
  require path
end

#in case active_support/inflector is required without the rest of active_support

#require 'active_support/inflector/inflections'
#require 'active_support/inflector/transliterate'
#require 'active_support/inflector/methods'

#require 'active_support/inflections'
#require 'active_support/core_ext/string/inflections'
