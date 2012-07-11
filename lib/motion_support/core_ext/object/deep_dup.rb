require 'bubble-wrap/loader'
BubbleWrap.require('motion/core_ext/object/*.rb') do
  file('motion/core_ext/object/deep_dup.rb').depends_on('motion/core_ext/object/duplicable.rb')
end
