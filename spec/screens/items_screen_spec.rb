describe ItemsScreen do

  tests ItemsScreen, :storyboard => 'main', :id => 'ItemsScreen'

  describe "#items" do
    it "is accessable" do
      controller.items.should.not.be.nil
    end
  end

  describe "#idx" do
    it "is accessable" do
      controller.idx.should.not.be.nil
    end
  end
end
