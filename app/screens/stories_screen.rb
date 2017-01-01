class StoriesScreen < PM::Screen
  title 'Stories'._

  def load_view
    @layout = StoriesLayout.new
    self.view = @layout.view
  end

  def on_load
    self.view.backgroundColor = '#fff0e6'.uicolor

    set_nav_bar_button :left, image: icon_image(:foundation, :widget, size: 18, color: '#606f79'.uicolor), action: :open_settings
    set_nav_bar_button :right, image: icon_image(:foundation, :refresh, size: 18, color: '#606f79'.uicolor), action: 'refresh_button_clicked:'

    collection = @layout.get(:collection)
    collection.dataSource = self
    collection.delegate = self
    collection.allowsSelection = false
    collection.allowsMultipleSelection = false
    [StoriesCell].each do |cell_class|
      collection.registerClass(cell_class, forCellWithReuseIdentifier: cell_class::REUSE_ID)
    end

    @refreshControl = UIRefreshControl.new
    @refreshControl.tintColor = [255,153,0].uicolor
    @refreshControl.addTarget(self, action: 'refresh_control_changed:', forControlEvents: UIControlEventValueChanged)
    collection.addSubview(@refreshControl)

    @segc = UISegmentedControl.plain Readom.topic_titles.map {|t| t._ }
    @segc.tintColor = :white.uicolor
    @segc.momentary = false
    #@segc.selectedSegmentIndex = 0
    @segc.addTarget(self, action: 'topic_seg_changed:', forControlEvents: UIControlEventValueChanged)
    self.navigationItem.titleView = @segc

    if @data.nil?
      Readom.current_topic = (NSUserDefaults['defaultReadomList'] || :topstories).to_sym
      Readom.current_topic_idx do |idx|
        @segc.selectedSegmentIndex = idx
      end
      set_data(pull: true)
    end
  end

  def will_appear
  end

  def on_appear
  end

  def will_disappear
  end

  def numberOfSectionsInCollectionView(collectionView)
    1
  end

  def collectionView(collectionView, numberOfItemsInSection: section)
    @data[Readom.current_topic].count
  end

  def collectionView(collectionView, cellForItemAtIndexPath: index)
    reuse_id = StoriesCell::REUSE_ID
    item = @data[Readom.current_topic][index.row]
    cell = collectionView.dequeueReusableCellWithReuseIdentifier reuse_id,
      forIndexPath: index
    cell.setItem item, targetViewController: self

    cell
  end

  def collectionView(collectionView, layout: layout, sizeForItemAtIndexPath: index)
    # ✗ |m[c]mm[c]mm[c]m| --- (cell + margin * ) * npl + margin * 2 = width
    # ✓ m|[c]mm[c]mm[c]|m --- (cell + margin * 2) * npl = width + margin * 2
    margin = CGPoint.new 5, 5
    min_cell = CGSize.new 310, 125
    cv_size = collectionView.frame.size

    npl = (cv_size.width + margin.x * 2) / (min_cell.width + margin.x * 2)
    ntl = (index.row == 0 and npl >= 2) ? (npl).to_i : npl.to_i
    cell_width = (cv_size.width + margin.x * 2) / ntl - margin.x * 2
    cell_height = [46500 / cell_width, min_cell.height].max

    [cell_width, cell_height]
  end

  def collectionView(collectionView, didSelectItemAtIndexPath: index)
    # cell = collectionView.cellForItemAtIndexPath(index)
  end

  def viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    @layout.get(:collection).collectionViewLayout.invalidateLayout()

    super
  end

  def prefersStatusBarHidden
    false
  end

private
  def set_data(params = {})
    topic = params.fetch :topic, Readom.current_topic
    count = params.fetch :count, 24
    pull = params.fetch :pull, false

    @data ||= {}
    @data[topic] ||= []

    pull = true if @data[topic].size == 0

    @layout.get(:collection).fade_out(opacity: 0.3)

    if pull
      @refreshControl.beginRefreshing
      Readom.fetch_items(topic, count) do |items|
        @refreshControl.endRefreshing
        @layout.get(:collection).fade_in

        sore_key = topic == :newstories ? 'time' : 'score'

        @data[topic] = items.sort{|x, y| y[sore_key] <=> x[sore_key]}

        @layout.get(:collection).reloadData
        self.title = '%s %s' % [Readom.current_topic_title._, 'Stories'._]
      end
    else
      @layout.get(:collection).fade_in
      @layout.get(:collection).reloadData
      self.title = '%s %s' % [Readom.current_topic_title._, 'Stories'._]
    end
  end

  def topic_seg_changed(sender)
    selected_topic = Readom.topics[sender.selectedSegmentIndex]
    selected_topic_title = Readom.topic_titles[sender.selectedSegmentIndex]

    Readom.current_topic = selected_topic

    set_data(pull: false)
  end

  def force_refresh(sender)
    set_data(pull: true)
  end
  alias :refresh_control_changed :force_refresh
  alias :refresh_button_clicked :force_refresh

  def open_settings
    UIApplicationOpenSettingsURLString.nsurl.open
  end
end
