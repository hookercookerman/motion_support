require 'bubble-wrap/loader'
Dir["#{File.dirname(__FILE__)}/object/*.rb"].sort.each do |path|
  require path
end

