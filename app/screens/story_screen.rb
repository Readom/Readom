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
    @notification = CWStatusBarNotification.new
    @notification.notificationLabelBackgroundColor = [255, 102, 0].uicolor
    @notification.notificationLabelTextColor = color.white

    refresher = UIRefreshControl.new
    refresher.addTarget(self, action: 'reload_items', forControlEvents: UIControlEventValueChanged)
    @refreshControl = refresher

    collectionView.tap do |cv|
      cv.alwaysBounceVertical = true
      cv.addSubview(@refreshControl)

      cv.registerClass(StoryCell, forCellWithReuseIdentifier: STORY_CELL_ID)
      cv.delegate = self
      cv.dataSource = self
      cv.allowsSelection = true
      cv.allowsMultipleSelection = false
      find(cv).apply_style :collection_view
    end

    @switch_topic_btn = screen.append!(UIButton, :switch_topic_btn)
    @switch_topic_btn.setAttributedTitle(:random.awesome_icon(size: 28, color: [255, 102, 0].uicolor), forState:UIControlStateNormal)
    @switch_topic_btn.addTarget(self,
      action: :switch_topic,
      forControlEvents: UIControlEventTouchUpInside)

    @refresh_btn = screen.append!(UIButton, :refresh_btn)
    @refresh_btn.setAttributedTitle(:refresh.awesome_icon(size: 28, color: [255, 102, 0].uicolor), forState:UIControlStateNormal)
    @refresh_btn.addTarget(self,
      action: :reload_items,
      forControlEvents: UIControlEventTouchUpInside)

    @version_label = screen.append!(UILabel, :version_label)
    @version_label.attributedText = :anchor.awesome_icon(size: 9) + app.short_version
    @version_label.sizeToFit
    @version_label.userInteractionEnabled = true
    tapGesture = UITapGestureRecognizer.alloc.initWithTarget(self, action: :version_label_clicked)
    tapGesture.numberOfTapsRequired = 5
    @version_label.addGestureRecognizer(tapGesture)

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
    show_in_sfsvc(@data[index_path.row]) do end
  end

  # Remove the following if you're only using portrait
  def will_animate_rotate(orientation, duration)
    reapply_styles
  end

private
  def set_data
    @data ||= []

    Readom.fetch_items(current_topic, 24) do |items|
      @refreshControl.endRefreshing
      @notification.displayNotificationWithMessage('%s' % current_topic, forDuration: 2.4)

      @data = items.sort{|x, y| y['time'] <=> x['time']}

      self.collectionView.reloadData
    end
  end

  def version_label_clicked
    @notification.displayNotificationWithMessage('%s' % app.info_plist['VersionFingerprint'], forDuration: 5)
  end

  def reload_items
    @notification.displayNotificationWithMessage('Reloading %s' % current_topic, forDuration: 1.5)

    set_data
  end

  def switch_topic
    @current_topic_idx += 1
    if @current_topic_idx >= topics.size
      @current_topic_idx = 0
    end

    @notification.displayNotificationWithMessage('Switching to %s' % current_topic, forDuration: 1.5)

    set_data
  end

  def current_topic
    @current_topic_idx ||= 0
    topics[@current_topic_idx]
  end

  def topics
    [:topstories, :beststories, :newstories, :askstories, :showstories, :jobstories]
  end

  def show_in_sfsvc(item, &block)
    sfsViewController = ReadomSafariViewController.alloc.initWithURL(NSURL.URLWithString item['url'], entersReaderIfAvailable: true)
    sfsViewController.delegate = sfsViewController
    sfsViewController.item = item
    sfsViewController.preferredBarTintColor = [255, 102, 0].uicolor
    sfsViewController.preferredControlTintColor = color.white

    self.presentViewController(sfsViewController,
      animated: true,
      completion: block)
  end
end
