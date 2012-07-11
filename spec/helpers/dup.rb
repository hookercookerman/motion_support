## Dups the singleton and yields, restoring the original inflections later.
## Use this in tests what modify the state of the singleton.
##
## This helper is implemented by setting @__instance__ because in some tests
## there are module functions that access MotionSupport::Inflector.inflections,
## so we need to replace the singleton itself.
def with_dup(&block)
  original = MotionSupport::Inflector.inflections
  MotionSupport::Inflector::Inflections.instance_variable_set(:@__instance__, original.dup)
  block.call
  MotionSupport::Inflector::Inflections.instance_variable_set(:@__instance__, original)
end

