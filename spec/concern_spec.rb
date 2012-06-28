class ConcernTest
  module Baz
    extend MotionSupport::Concern

    module ClassMethods
      def baz
        "baz"
      end

      def included_ran=(value)
        @@included_ran = value
      end

      def included_ran
        @@included_ran
      end
    end

    included do
      self.included_ran = true
    end

    def baz
      "baz"
    end
  end

  module Bar
    extend MotionSupport::Concern

    include Baz

    def bar
      "bar"
    end

    def baz
      "bar+" + super
    end
  end

  module Foo
    extend MotionSupport::Concern

    include Bar, Baz
  end
end

describe "Concern" do
  before do
    @klass = Class.new
  end

  it "should include modules normally" do
    @klass.send(:include, ConcernTest::Baz)
    "baz".should.equal @klass.new.baz
    @klass.included_modules.should.include?(ConcernTest::Baz)
    @klass.included_modules.should.include?(ConcernTest::Baz)

    @klass.send(:include, ConcernTest::Baz)
    "baz".should.equal(@klass.new.baz)
    @klass.included_modules.should.include?(ConcernTest::Baz)
  end

  it "should extend class methods" do
    @klass.send(:include, ConcernTest::Baz)
    ConcernTest::Baz::ClassMethods.should.equal((class << @klass; self.included_modules; end)[0])
  end

  it "should include instance methods" do
    @klass.send(:include, ConcernTest::Baz)
    "baz".should.equal @klass.new.baz
    @klass.included_modules.should.include?(ConcernTest::Baz)
  end

  it "should run the include block" do
    @klass.send(:include, ConcernTest::Baz)
    @klass.included_ran.should.equal(true)
  end

  it "should meet module dependencies" do
    @klass.send(:include, ConcernTest::Bar)
    "bar".should.equal @klass.new.bar
    "bar+baz".should.equal @klass.new.baz
    "baz".should.equal @klass.baz
    @klass.included_modules.should.include?(ConcernTest::Bar)
  end

  it "should be cool with multiply modules" do
    @klass.send(:include, ConcernTest::Foo)
    [ConcernTest::Foo, ConcernTest::Bar, ConcernTest::Baz].should.equal(@klass.included_modules[0..2])
  end
end
