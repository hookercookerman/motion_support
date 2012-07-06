require 'bubble-wrap/loader'
BubbleWrap.require('motion/**/*.rb') do
  file('motion/inflections.rb').depends_on('motion/inflector/inflections.rb')
end
