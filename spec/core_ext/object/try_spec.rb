describe "ObjectTry"do
  before do
    @string = "Hello"
  end

  it "nonexisting method" do
    method = :undefined_method
    @string.respond_to?(method).should.not == true
    lambda{  @string.try(method)}.should.raise(NoMethodError)
  end

  it "nonexisting method with arguments" do
    method = :undefined_method
    @string.respond_to?(method).should.not == true
    lambda{ @string.try(method, 'llo', 'y') }.should.raise(NoMethodError)
  end

  it "valid method" do
    @string.try(:size).should == 5
  end

  it "argument forwarding" do
     @string.try(:sub, 'llo', 'y').should.equal("Hey")
  end

  it "block forwarding" do
    @string.try(:sub, 'llo') { |match| 'y' }.should.equal("Hey")
  end

  it "nil to type" do
    nil.try(:to_s).should == nil
    nil.try(:to_i).should == nil
  end

  it "false try" do
    false.try(:to_s).should == 'false'
  end

  it "try only block" do
    @string.try { |s| s.reverse }.should == @string.reverse
  end

  it "try only block nil" do
    ran = false
    nil.try { ran = true }
    ran.should == false
  end

  it "try with private method" do
    klass = Class.new do
      private

      def private_method
        'private method'
      end
    end
    
    lambda{ klass.new.try(:private_method) }.should.raise(NoMethodError)
  end
end
