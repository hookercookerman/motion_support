require 'bubble-wrap/loader'
Dir["#{File.dirname(__FILE__)}/array/*.rb"].sort.each do |path|
  require path
end
