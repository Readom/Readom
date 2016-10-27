describe "Class 'String'" do
  before do
    @sample_string = "#THIS IS SAMPLE STRING#"
  end
  it "translate to itself when not defined" do
    @sample_string._.should == @sample_string
  end
end
