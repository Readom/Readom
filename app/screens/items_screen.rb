class ItemsScreen < UITableViewController
  extend IB

  attr_accessor :items, :idx

  def viewDidLoad
    super

    @items = []
    @idx = 0

    select_idx(:next)
  end

  def tableView(tableView, numberOfRowsInSection: section)
    @items.size
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    cell(indexPath)
  end

  def prepareForSegue(segue, sender:sender)
    if segue.identifier == 'ShowItem'
      @item_vc = segue.destinationViewController
      @item_vc.delegate = self
      @item_vc.item = sender.item
      @idx = self.tableView.indexPathForSelectedRow.row
    end
  end

  # def performSegueWithIdentifier(segue, sender:sender)
  #   super
  # end

  def favorite_item(sender)
    next_item(sender)
  end

  def next_item(sender)
    select_idx(:next)
  end

  def select_idx(idx=nil)
    idx = fetch_next_idx if idx.nil? or idx == :next
    indexPath = [0, idx].nsindexpath

    if self.navigationController.viewControllers[-1] != self
      self.navigationController.popViewControllerAnimated false
    end

    self.tableView.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: UITableViewScrollPositionMiddle)
    self.performSegueWithIdentifier 'ShowItem', sender: cell(indexPath)
  end

  private

  def cell(indexPath)
    @reuseIdentifier ||= 'ItemCell'

    self.tableView.cellForRowAtIndexPath(indexPath) || begin
      cell = self.tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier)
      cell.item = @items[indexPath.row]

      cell
    end
  end

  def fetch_next_idx
    if @idx + 1 >= @items.size
      fetch_items
      @idx = 0
    else
      @idx += 1
    end

    @idx
  end

  def fetch_items
    items = HN.shared_instance.more.items

    if items.size > 0
      @items = items
      self.tableView.reloadData
    end
  end
end
