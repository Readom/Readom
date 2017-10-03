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
        user_id = e.peekAtSearchWithXPathQuery("//*[@class='comhead']/a[@class='hnuser']").text
        content = e.peekAtSearchWithXPathQuery("//*[@class='comment']/span[@class]").text

        # <div class="comment">
        #   <span class="c00">
        #     The key achievement, imho:
        #     <p>&gt; In the mid-1970s, Rainer Weiss had already analysed possible sources of background noise that would disturb measurements, and had also designed a detector, a laser-based interferometer, which would overcome this noise.</p>
        #     <p>Over 40 years ago, Weiss figured out <i>how</i> to do it. And finally, within his lifetime, he got to see it happen and actually work.
        #       <span>
        #               </span>
        #     </p>
        #     <div class="reply">
        #       <p><font size="1">
        #                       <u><a href="reply?id=15391304&amp;goto=item%3Fid%3D15391282%2315391304">reply</a></u>
        #                   </font>
        #       </p>
        #     </div>
        #   </span>
        # </div>

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
