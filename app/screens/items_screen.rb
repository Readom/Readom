class ItemsScreen < UITableViewController
  extend IB

  def tableView(tableView, numberOfRowsInSection: section)
    items.size
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= 'ItemCell'
    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier)
    cell.item ||= items[indexPath.row]

    cell
  end

  private

  def items
    @items ||= doc.searchWithXPathQuery("//tr[@class='athing']").map do |e|
      link = e.searchWithXPathQuery("//a[@class='storylink']").first

      {
        id: e[:id],
        title: link.text,
        url: link[:href].nsurl(baseurl).absoluteString
      }.to_object
    end
  end

  def morelink
    @morelink ||= doc.searchWithXPathQuery("//a[@class='morelink']").first
    @morelink[:href].nsurl(baseurl)
  end

  def doc(link=nil)
    link ||= baseurl

    @doc ||= begin
      doc = TFHpple.alloc.initWithHTMLData link.nsurl.nsdata
      @items = @morelink = nil

      doc
    end
  end

  def baseurl
    @baseurl ||= "https://news.ycombinator.com".nsurl
  end
end
