require 'bubble-wrap/loader'
BubbleWrap.require('motion/inflector/*.rb') do 
  file('motion/inflector/inflections.rb').depends_on 'motion/core_ext/array/prepend_append.rb'
end
