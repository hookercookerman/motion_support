describe "Array" do
  describe "Extract Options" do
    class HashSubclass < Hash
    end

    class ExtractableHashSubclass < Hash
      def extractable_options?
        true
      end
    end

    it "should extract those options" do
      {}.should.equal([].extract_options!)
      {}.should.equal([1].extract_options!)
      {:a=>:b}.should.equal([{:a=>:b}].extract_options!)
      {:a=>:b}.should.equal([1, {:a=>:b}].extract_options!)
    end

    it "should extract hash subclasses" do
      hash = HashSubclass.new
      hash[:foo] = 1
      array = [hash]
      options = array.extract_options!
      options.should.equal({})
      [hash].should.equal(array)
    end

    it "should extract options extracts extractable subclasses" do
      hash = ExtractableHashSubclass.new
      hash[:foo] = 1
      array = [hash]
      options = array.extract_options!
      {:foo => 1}.should.equal(options)
      [].should.equal(array)
    end
    
    # @todo awaiting with indifferent access
    #it "should extracts hwia" do
      #hash = [{:foo => 1}.with_indifferent_access]
      #options = hash.extract_options!
      #options[:foo].should.equal(1)
    #end

  end
end

