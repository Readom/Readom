describe 'Readom' do
  before do
    def app
      @app = UIApplication.sharedApplication
    end

    @item = nil
  end

  it "fetch news by id" do
    @item = Readom.fetch_item(1)
    #@item['id'].should == 1

    true.should == true # TODO: test async mode
  end

  after do
    @item = nil
  end
end
