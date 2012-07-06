describe "Array" do

  describe "#append" do
    it "should prepend elements on the array" do
      [1].append(2).should.equal([1,2])
    end
  end

  describe "#prepend" do
    it "shoudl prepend elements on the array" do
      [1].prepend(2).should.equal([2,1])
    end
  end

end
