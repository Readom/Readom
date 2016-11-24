class StoryScreen < UICollectionViewController
  include ProMotion::ScreenModule

  title "Top Stories"
  stylesheet StoryScreenStylesheet

  STORY_CELL_ID = "StoryCell"

  def self.new(args = {})
    # Set layout
    layout = UICollectionViewFlowLayout.alloc.init
    s = self.alloc.initWithCollectionViewLayout(layout)
    s.screen_init(args) if s.respond_to?(:screen_init)
    s
  end

  def on_load
    collectionView.tap do |cv|
      cv.registerClass(StoryCell, forCellWithReuseIdentifier: STORY_CELL_ID)
      cv.delegate = self
      cv.dataSource = self
      cv.allowsSelection = true
      cv.allowsMultipleSelection = false
      find(cv).apply_style :collection_view
    end

    set_data unless @data
  end

  def numberOfSectionsInCollectionView(view)
    1
  end

  def collectionView(view, numberOfItemsInSection: section)
    @data.count
  end

  def collectionView(view, cellForItemAtIndexPath: index_path)
    view.dequeueReusableCellWithReuseIdentifier(STORY_CELL_ID, forIndexPath: index_path).tap do |cell|
      self.rmq.build(cell) unless cell.reused

      # Update cell's data here
      cell.set @data[index_path.row]
    end
  end

  def collectionView(view, didSelectItemAtIndexPath: index_path)
    cell = view.cellForItemAtIndexPath(index_path)
    # puts "Selected at section: #{index_path.section}, row: #{index_path.row}"
    show_in_sfsvc(@data[index_path.row]['url']) do end
  end

  # Remove the following if you're only using portrait
  def will_animate_rotate(orientation, duration)
    reapply_styles
  end

private
  def set_data
    @data = []
    Readom.fetch_items(:topstories, 20) do |item|
      @data << item

      self.collectionView.reloadData
    end
  end

  def show_in_sfsvc(url, &block)
    sfsViewController = SFSafariViewController.alloc.initWithURL(NSURL.URLWithString url, entersReaderIfAvailable: true)
    #sfsViewController.delegate = @targetViewController | self
    #sfsViewController.preferredBarTintColor = UIColor.colorWithRed(0.45, green: 0.70, blue: 0.90, alpha: 0.25)
    #sfsViewController.preferredControlTintColor = UIColor.colorWithRed(0.45, green: 0.70, blue: 0.90, alpha: 0.25)

    self.presentViewController(sfsViewController,
      animated: true,
      completion: block)
  end
end
