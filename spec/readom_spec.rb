describe "Class 'Readom'" do
  before do
  end

  it "fetch_item_sample shoud return array only 1 id" do
    result = Readom.fetch_item_sample

    result.class.should == Array
    result.size.should == 1
  end

  it "fetch_item_sample shoud return array with no less than 1 ids" do
    result = Readom.fetch_items

    result.class.should == Array
    result.size.should >= 1
  end
end
