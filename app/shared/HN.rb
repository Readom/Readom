class HN

  class User

    attr_accessor :id, :name

    def initialize(params)
      @id = params[:id]
      @name = params[:name]
    end
  end

  class Comment

    attr_accessor :id, :user_id, :content

    def initialize(params)
      @id = params[:id]
      @user_id = params[:user_id]
      @content = params[:content]
    end
  end

  class Story

    attr_accessor :id, :title, :url

    def initialize(params)
      @id = params[:id]
      @title = params[:title]
      @url = params[:url]
    end

    def comments
      @comments ||= []

      doc = TFHpple.alloc.initWithHTMLData story_url.nsurl.nsdata
      doc.searchWithXPathQuery("//table[@class='comment-tree']/tr[@class='athing comtr ']").map do |e|
        id = e[:id]

        user_id = e.peekAtSearchWithXPathQuery("//*[@class='comhead']/a[@class='hnuser']")
        user_id = user_id.text if user_id

        content = e.peekAtSearchWithXPathQuery("//*[@class='comment']/span[@class]")
        content = content.text if content

        Comment.new id: id, user_id: user_id, content: content
      end
    end

    private

    def story_url
      'https://news.ycombinator.com/item?id=%s' % @id
    end
  end

  class << self

    def shared_instance
      @instance ||= self.new
    end
  end

  attr_reader :items

  def initialize
    @items = []
    @morepage = nil
  end

  def more
    doc = TFHpple.alloc.initWithHTMLData(
      ( @morepage.nil? ? baseurl.nsurl : @morepage.nsurl(baseurl) ).nsdata
    )

    @morepage = doc.peekAtSearchWithXPathQuery("//a[@class='morelink']")[:href]
    @items = doc.searchWithXPathQuery("//tr[@class='athing']").map do |e|
      link = e.peekAtSearchWithXPathQuery("//a[@class='storylink']")

      Story.new id: e[:id],
            title: link.text,
              url: link[:href].nsurl(baseurl).absoluteString
    end

    self
  end

  private

  def baseurl
    @baseurl ||= "https://news.ycombinator.com".nsurl
  end
end
