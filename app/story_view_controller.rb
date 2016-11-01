class StoriesViewController < UIViewController
  @sectionInsets = UIEdgeInsetsMake(50.0, 20.0, 50.0, 20.0)

  def initWithNibName(name, bundle: bundle)
    super
    self.title = "Story"._
    self.tabBarItem = UITabBarItem.alloc.initWithTitle("Collection"._, image: nil, tag: 0)

    self
  end

  def loadView
    @layout = StoriesLayout.new
    self.view = @layout.view
  end

  def viewDidLoad
    @layout.table.autoresizingMask = UIViewAutoresizingFlexibleHeight
    @layout.table.dataSource = self
    @layout.table.delegate = self

    @data = []
    Readom.fetch_items do |id, title, url|
      @data << [id, title, url]
      @layout.table.reloadData
    end
  end

  def viewDidAppear(animated)
    super
  end

  # DataSource
  def tableView(tableView, numberOfRowsInSection: section)
    @data.count
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier = "DemoCell"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier)
    cell ||= UITableViewCell.alloc.initWithStyle(
      UITableViewCellStyleDefault,
      reuseIdentifier:@reuseIdentifier
    )
    cell.text = @data[indexPath.row][1]
    cell.textAlignment = UITextAlignmentCenter

    cell
  end
  # end DataSource

  # Delegate
  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)

    self.presentViewController(SFSafariViewController.alloc.initWithURL(NSURL.URLWithString @data[indexPath.row][2], entersReaderIfAvailable: true),
      animated: true,
      completion: nil)
  end
  # end Delegate
end

class StoriesLayout < MotionKit::Layout
  view :table

  def layout
    background_color UIColor.colorWithRed(0.81, green: 0.91, blue: 0.86, alpha: 1.0)

    add UILabel, :title_label
    add UITableView, :table
  end

  def title_label_style
    text "Stories"._
    size_to_fit

    center ['50%', '0% + 90']
  end

  def table_style
    autoresizing_mask :pin_to_top, :flexible_height, :flexible_width

    width '100% - 10'
    frame below(:title_label, down: 5, height: '100% - 160')
    x 5
  end
end
