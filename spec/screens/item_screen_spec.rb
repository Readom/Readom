describe ItemScreen do

  before do
    controller.item = HN::Item.new({id: '1', title: 'title1', url: 'https://news.ycombinator.com/item?id=1'})
  end

  tests ItemScreen, :storyboard => 'main', :id => 'ItemScreen'

  describe "#titleLabel" do
    it "is connected in the storyboard" do
      controller.titleLabel.should.not.be.nil
    end
  end

  describe "#commentLabel" do
    it "is connected in the storyboard" do
      controller.commentLabel.should.not.be.nil
    end
  end
end
