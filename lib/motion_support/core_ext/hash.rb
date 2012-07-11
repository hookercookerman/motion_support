require 'bubble-wrap/loader'
Dir["#{File.dirname(__FILE__)}/hash/*.rb"].sort.each do |path|
  require path
end
