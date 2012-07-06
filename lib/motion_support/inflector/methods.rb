require 'bubble-wrap/loader'
BubbleWrap.require('motion/inflector/*.rb') do
  file('motion/inflector/methods.rb').depends_on('motion/inflector/inflections.rb')
end

