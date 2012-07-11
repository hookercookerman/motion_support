describe "Hash Keys" do
  before do
    @strings = { 'a' => 1, 'b' => 2 }
    @nested_strings = { 'a' => { 'b' => { 'c' => 3 } } }
    @symbols = { :a  => 1, :b  => 2 }
    @nested_symbols = { :a => { :b => { :c => 3 } } }
    @mixed   = { :a  => 1, 'b' => 2 }
    @nested_mixed   = { 'a' => { :b => { 'c' => 3 } } }
    @fixnums = {  0  => 1,  1  => 2 }
    @nested_fixnums = {  0  => { 1  => { 2 => 3} } }
    @illegal_symbols = { [] => 3 }
    @nested_illegal_symbols = { [] => { [] => 3} }
    @upcase_strings = { 'A' => 1, 'B' => 2 }
    @nested_upcase_strings = { 'A' => { 'B' => { 'C' => 3 } } }
  end

  it "methods" do
    h = {}
    h.respond_to?(:transform_keys).should == true
    h.respond_to?(:transform_keys!).should == true
    h.respond_to?(:deep_transform_keys).should == true
    h.respond_to?(:deep_transform_keys!).should == true
    h.respond_to?(:symbolize_keys).should == true
    h.respond_to?(:symbolize_keys!).should == true
    h.respond_to?(:deep_symbolize_keys).should == true
    h.respond_to?(:deep_symbolize_keys!).should == true
    h.respond_to?(:stringify_keys).should == true
    h.respond_to?(:stringify_keys!).should == true
    h.respond_to?(:deep_stringify_keys).should == true
    h.respond_to?(:deep_stringify_keys!).should == true
    h.respond_to?(:to_options).should == true
    h.respond_to?(:to_options!).should == true
  end

  it "transform keys" do
    @strings.transform_keys{ |key| key.to_s.upcase }.should == @upcase_strings
    @symbols.transform_keys{ |key| key.to_s.upcase }.should == @upcase_strings
    @mixed.transform_keys{ |key| key.to_s.upcase }.should == @upcase_strings
  end

  it "transform keys not mutates" do
    transformed_hash = @mixed.dup
    transformed_hash.transform_keys{ |key| key.to_s.upcase }
    transformed_hash.should == @mixed
  end

  it "deep transform keys" do
    @nested_symbols.deep_transform_keys{ |key| key.to_s.upcase }.should == @nested_upcase_strings
    @nested_strings.deep_transform_keys{ |key| key.to_s.upcase }.should == @nested_upcase_strings
    @nested_mixed.deep_transform_keys{ |key| key.to_s.upcase }.should == @nested_upcase_strings
  end

  it "deep transform keys not mutates" do
    transformed_hash = @nested_mixed.deep_dup
    transformed_hash.deep_transform_keys{ |key| key.to_s.upcase }
    transformed_hash.should == @nested_mixed
  end

  it "transform keys!" do
    @symbols.dup.transform_keys!{ |key| key.to_s.upcase }.should == @upcase_strings
    @strings.dup.transform_keys!{ |key| key.to_s.upcase }.should == @upcase_strings
    @mixed.dup.transform_keys!{ |key| key.to_s.upcase }.should == @upcase_strings
  end

  it "transform keys with bang mutates" do
    transformed_hash = @mixed.dup
    transformed_hash.transform_keys!{ |key| key.to_s.upcase }
    transformed_hash.should == @upcase_strings
    { :a => 1, "b" => 2 }.should.equal(@mixed)
  end

  it "deep transform keys!" do
    @nested_symbols.deep_dup.deep_transform_keys!{ |key| key.to_s.upcase }.should == @nested_upcase_strings
    @nested_strings.deep_dup.deep_transform_keys!{ |key| key.to_s.upcase }.should == @nested_upcase_strings
    @nested_mixed.deep_dup.deep_transform_keys!{ |key| key.to_s.upcase }.should == @nested_upcase_strings
  end

  it "deep transform keys with bang mutates" do
    transformed_hash = @nested_mixed.deep_dup
    transformed_hash.deep_transform_keys!{ |key| key.to_s.upcase }
    transformed_hash.should == @nested_upcase_strings
    { 'a' => { :b => { 'c' => 3 } } }.should == @nested_mixed
  end

  it "symbolize keys" do
    @symbols.symbolize_keys.should == @symbols
    @strings.symbolize_keys.should == @symbols
    @mixed.symbolize_keys.should == @symbols
  end

  it "symbolize keys not mutates" do
    transformed_hash = @mixed.dup
    transformed_hash.symbolize_keys
    transformed_hash.should == @mixed
  end

  it "deep symbolize keys" do
    @nested_symbols.deep_symbolize_keys.should == @nested_symbols
    @nested_strings.deep_symbolize_keys.should == @nested_symbols
    @nested_mixed.deep_symbolize_keys.should == @nested_symbols
  end

  it "deep symbolize keys not mutates" do
    transformed_hash = @nested_mixed.deep_dup
    transformed_hash.deep_symbolize_keys
    transformed_hash.should == @nested_mixed
  end

  it "symbolize keys!" do
    @symbols.dup.symbolize_keys!.should == @symbols
    @strings.dup.symbolize_keys!.should == @symbols
    @mixed.dup.symbolize_keys!.should == @symbols
  end

  it "symbolize keys with bang mutates" do
    transformed_hash = @mixed.dup
    transformed_hash.deep_symbolize_keys!
    transformed_hash.should == @symbols
    { :a => 1, "b" => 2 }.should.equal(@mixed)
  end

  it "deep symbolize keys!" do
    @nested_symbols.deep_dup.deep_symbolize_keys!.should == @nested_symbols
    @nested_strings.deep_dup.deep_symbolize_keys!.should == @nested_symbols
    @nested_mixed.deep_dup.deep_symbolize_keys!.should == @nested_symbols
  end

  it "deep symbolize keys with bang mutates" do
    transformed_hash = @nested_mixed.deep_dup
    transformed_hash.deep_symbolize_keys!
    transformed_hash.should == @nested_symbols
    { 'a' => { :b => { 'c' => 3 } } }.should == @nested_mixed
  end

  it "symbolize keys preserves keys that cant be symbolized" do
    @illegal_symbols.symbolize_keys.should == @illegal_symbols
    @illegal_symbols.dup.symbolize_keys!.should == @illegal_symbols
  end

  it "deep symbolize keys preserves keys that cant be symbolized" do
    @nested_illegal_symbols.deep_symbolize_keys.should == @nested_illegal_symbols
    @nested_illegal_symbols.deep_dup.deep_symbolize_keys!.should == @nested_illegal_symbols
  end

  it "symbolize keys preserves fixnum keys" do
    @fixnums.symbolize_keys.should == @fixnums
    @fixnums.dup.symbolize_keys!.should == @fixnums
  end

  it "deep symbolize keys preserves fixnum keys" do
    @nested_fixnums.deep_symbolize_keys.should == @nested_fixnums
    @nested_fixnums.deep_dup.deep_symbolize_keys!.should == @nested_fixnums
  end

  it "stringify keys" do
    @symbols.stringify_keys.should == @strings
    @strings.stringify_keys.should == @strings
    @mixed.stringify_keys.should == @strings
  end

  it "stringify keys not mutates" do
    transformed_hash = @mixed.dup
    transformed_hash.stringify_keys
    transformed_hash.should == @mixed
  end

  it "deep stringify keys" do
    @nested_symbols.deep_stringify_keys.should == @nested_strings
    @nested_strings.deep_stringify_keys.should == @nested_strings
    @nested_mixed.deep_stringify_keys.should == @nested_strings
  end

  it "deep stringify keys not mutates" do
    transformed_hash = @nested_mixed.deep_dup
    transformed_hash.deep_stringify_keys
    transformed_hash.should == @nested_mixed
  end

  it "stringify keys!" do
    @symbols.dup.stringify_keys!.should == @strings
    @strings.dup.stringify_keys!.should == @strings
    @mixed.dup.stringify_keys!.should == @strings
  end

  it "stringify keys with bang mutates" do
    transformed_hash = @mixed.dup
    transformed_hash.stringify_keys!
    transformed_hash.should == @strings
    { :a => 1, "b" => 2 }.should.equal(@mixed)
  end

  it "deep stringify keys!" do
    @nested_symbols.deep_dup.deep_stringify_keys!.should == @nested_strings
    @nested_strings.deep_dup.deep_stringify_keys!.should == @nested_strings
    @nested_mixed.deep_dup.deep_stringify_keys!.should == @nested_strings
  end

  it "deep stringify keys with bang mutates" do
    transformed_hash = @nested_mixed.deep_dup
    transformed_hash.deep_stringify_keys!
    transformed_hash.should == @nested_strings
    { 'a' => { :b => { 'c' => 3 } } }.should == @nested_mixed
  end

end
