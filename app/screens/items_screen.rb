class ItemsScreen < UITableViewController
  extend IB

  attr_accessor :currentIndexPath

  def viewDidLoad
    super

    fetch_items
  end

  def tableView(tableView, numberOfRowsInSection: section)
    items.size
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= 'ItemCell'
    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier)
    cell.item = items[indexPath.row]

    cell
  end

  def prepareForSegue(segue, sender:sender)
    if segue.identifier == 'ShowItem'
      @item_vc = segue.destinationViewController
      @item_vc.delegate = self

      @item_vc.item = sender.item
    end
  end

  def favorite_item(sender)
    next_item(sender)
  end

  def next_item(sender)
    if currentIndexPath.row >= items.size - 1
      fetch_items(morelink)
    end
    return if currentIndexPath.row >= items.size - 1

    nextIndexPath = NSIndexPath.indexPathForRow(currentIndexPath.row + 1, inSection:currentIndexPath.section)
    cell = self.tableView.cellForRowAtIndexPath(nextIndexPath) || begin
      cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier)
      cell.item = items[indexPath.row]

      cell
    end

    self.navigationController.popViewControllerAnimated false
    self.performSegueWithIdentifier('ShowItem', sender: cell)
    self.tableView.selectRowAtIndexPath(nextIndexPath, animated: false, scrollPosition: UITableViewScrollPositionMiddle)

    @currentIndexPath = nextIndexPath
  end

  private

  def fetch_items(link=nil)
    doc(link)

    if items.size > 0
      self.tableView.reloadData

      self.performSegueWithIdentifier('ShowItem', sender: self.tableView.cellForRowAtIndexPath(currentIndexPath))
    end
  end

  def currentIndexPath
    @currentIndexPath ||= begin
      indexPath = self.tableView.indexPathForSelectedRow || NSIndexPath.indexPathForRow(0, inSection:0)
      NSIndexPath.indexPathForRow(indexPath.row, inSection:indexPath.section)
    end
  end

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
