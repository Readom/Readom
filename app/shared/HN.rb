class HN
  def self.shared_instance
    @instance ||= self.new
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

    @morepage = doc.searchWithXPathQuery("//a[@class='morelink']").first[:href]
    @items = doc.searchWithXPathQuery("//tr[@class='athing']").map do |e|
      link = e.searchWithXPathQuery("//a[@class='storylink']").first

      {
        id: e[:id],
        title: link.text,
        url: link[:href].nsurl(baseurl).absoluteString
      }.to_object
    end

    self
  end

  private

  def baseurl
    @baseurl ||= "https://news.ycombinator.com".nsurl
  end
end
