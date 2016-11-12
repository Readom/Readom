class GiveMeFiveViewController < UIViewController
  GIVE_ME_NUMBER = 6

  def initWithNibName(name, bundle: bundle)
    super
    self.title = "GiveMeFive"._
    self.tabBarItem = UITabBarItem.alloc.initWithTitle("Give Me 5"._, image: UIImage.imageNamed("tabbar/5-50.png"), tag: 0)
    self.edgesForExtendedLayout = UIRectEdgeAll
    self.extendedLayoutIncludesOpaqueBars = true
    self.automaticallyAdjustsScrollViewInsets = true

    self
  end

  def loadView
    @layout = GiveMeFiveLayout.new
    self.view = @layout.view

    @layout.vc = self
  end

  def viewDidLoad
    super
  end

  def viewDidAppear(animated)
    super
  end
end

class GiveMeFiveLayout < MotionKit::Layout
  view :action_button
  view :collection

  attr_accessor :vc

  def layout
    background_color UIColor.colorWithRed(0.90, green: 0.95, blue: 0.95, alpha: 1.0)

    add UIButton, :action_button

    flow_layout = UICollectionViewFlowLayout.alloc.init
    flow_layout.scrollDirection = UICollectionViewScrollDirectionVertical
    flow_layout.sectionInset = [2, 0, 2, 0]
    flow_layout.minimumLineSpacing = 1
    flow_layout.minimumInteritemSpacing = 1
    collection = UICollectionView.alloc.initWithFrame CGRectZero, collectionViewLayout: flow_layout
    add collection, :collection
  end

  def action_button_style
    background_color UIColor.colorWithRed(0.45, green: 0.70, blue: 0.90, alpha: 1.0)
    title_color UIColor.whiteColor
    contentEdgeInsets [10, 10, 10, 10]

    title "GiveMeFive"._
    size_to_fit

    constraints do
      bottom.equals(:superview).minus(52)
      width.equals(:superview)
      left.equals(:superview)
    end

    addTarget(self,
      action: :set_data,
      forControlEvents: UIControlEventTouchUpInside)
  end

  def collection_style
    background_color UIColor.colorWithRed(0.96, green: 0.96, blue: 0.96, alpha: 0.5)

    constraints do
      left.equals(:superview, :left)
      right.equals(:superview, :right)
      top.equals(:superview, :top).plus(64)
      bottom.equals(:action_button, :top).minus(23)
    end

    dataSource self
    delegate self
    registerClass GiveMeFiveCollectionCell, forCellWithReuseIdentifier: GiveMeFiveCollectionCell::IDENTIFIER

    set_data unless @data
  end

private
  def set_data
    @data = []
    Readom.fetch_items(:newstories, GiveMeFiveViewController::GIVE_ME_NUMBER) do |id, title, url, by, score, time|
      @data << [id, title, url, by, score, time]

      self.collection.reloadData
    end
  end

  def numberOfSectionsInCollectionView(collectionView)
    1
  end

  def collectionView(collectionView, numberOfItemsInSection: section)
    @data.count
  end

  def collectionView(collectionView, cellForItemAtIndexPath:indexPath)
    cell = collectionView.dequeueReusableCellWithReuseIdentifier(GiveMeFiveCollectionCell::IDENTIFIER, forIndexPath:indexPath)
    #cell ||= UICollectionViewCell.alloc.initWithStyle(
    #  UICollectionViewCellStyleDefault,
    #  reuseIdentifier:GiveMeFiveCollectionCell::IDENTIFIER
    #)
    id, title, url, by, score, time = @data[indexPath.row]
    cell.set(title, url, by, score, time, @vc)

    cell
  end

  def collectionView(collectionView, layout: layout, sizeForItemAtIndexPath: indexPath)
    full_width = collectionView.bounds.size.width
    full_height = collectionView.bounds.size.height

    per_line = 1
    margin = 1
    first_line_scale = {:x => per_line, :y => 2}
    total = GiveMeFiveViewController::GIVE_ME_NUMBER

    lines = (total - 1 + first_line_scale[:x]) / per_line

    per_width = (full_width - margin * (per_line - 1)) / per_line
    per_height = full_height / (lines - 1 + first_line_scale[:y]) - margin * 1

    first_line_width = Proc.new {|a, b| a < b ? a : b}.call(
      per_width * first_line_scale[:x] + margin * (first_line_scale[:x] - 1),
      full_width
    )

    indexPath.row == 0 ? [first_line_width, per_height * first_line_scale[:y]] : [per_width, per_height]
  end
end

class GiveMeFiveCollectionCell < UICollectionViewCell
  IDENTIFIER = 'GiveMeFiveCELL'

  def initWithFrame(frame)
    super

    @layout = GiveMeFiveCollectionCellLayout.new(root: self.contentView).build

    self
  end

  def set(title, url, by, score, time, targetViewController)
    @layout.set(title, url, by, score, time, targetViewController)
  end
end

class GiveMeFiveCollectionCellLayout < MK::Layout
  @url = nil
  @targetViewController = nil
  @by = nil
  @score = nil
  @time = nil

  def layout
    root :cell do
      add UILabel, :by_info_label
      add UILabel, :score_info_label
      add UILabel, :time_info_label

      add UILabel, :title_label, z_index: 1
      add UIButton, :view_button, z_index: 2
    end
  end

  def cell_style
    background_color UIColor.whiteColor
  end

  def by_info_label_style
    text_color UIColor.colorWithRed(0.5, green: 0.5, blue: 0.65, alpha: 0.8)
    numberOfLines 1
    font UIFont.fontWithName('Arial', size: 10)
    text_alignment NSTextAlignmentLeft

    constraints do
      left.equals(:superview, :left).plus(6)
      right.equals(:superview, :right).minus(48)
      top.equals(:superview, :top).plus(1)
      bottom.equals(:superview, :top).plus(12)
    end
  end

  def score_info_label_style
    text_color UIColor.colorWithRed(0.5, green: 0.5, blue: 0.65, alpha: 0.8)
    numberOfLines 1
    font UIFont.fontWithName('Arial', size: 12)
    text_alignment NSTextAlignmentCenter

    constraints do
      left.equals(:by_info_label,)
      right.equals(:by_info_label)
      top.equals(:by_info_label)
      bottom.equals(:by_info_label)
    end
  end

  def time_info_label_style
    text_color UIColor.colorWithRed(0.5, green: 0.5, blue: 0.65, alpha: 0.8)
    numberOfLines 1
    font UIFont.fontWithName('Arial', size: 10)
    text_alignment NSTextAlignmentRight

    constraints do
      left.equals(:by_info_label,)
      right.equals(:superview)
      top.equals(:by_info_label)
      bottom.equals(:by_info_label)
    end
  end

  def title_label_style
    text_color UIColor.colorWithRed(0.25, green: 0.25, blue: 0.25, alpha: 1.0)
    lineBreakMode NSLineBreakByWordWrapping
    numberOfLines 0
    constraints do
      left.equals(:superview, :left).plus(2)
      right.equals(:by_info_label)
      top.equals(:by_info_label, :bottom)
      bottom.equals(:superview)
    end

    userInteractionEnabled  true
    tapGesture = UITapGestureRecognizer.alloc.initWithTarget(self, action: :view_button_clicked)
    tapGesture.numberOfTapsRequired = 2
    addGestureRecognizer(tapGesture)
  end

  def view_button_style
    background_color UIColor.colorWithRed(0.45, green: 0.70, blue: 0.90, alpha: 1.0)

    title_color UIColor.whiteColor
    title_shadow_color UIColor.colorWithRed(0.45, green: 0.70, blue: 0.90, alpha: 0.25)
    title_shadow_offset [0, 1]
    title_font UIFont.fontWithName('Arial', size: 16)

    title 'VIEW'._
    size_to_fit

    constraints do
      left.equals(:title_label, :right).plus(1)
      right.equals(:superview)
      top.equals(:title_label).plus(5)
      bottom.equals(:title_label).minus(5)
    end

    addTarget(self,
      action: :view_button_clicked,
      forControlEvents: UIControlEventTouchUpInside)
  end

  def set(title, url, by, score, time, targetViewController)
    @url = url
    self.get(:title_label).text = title
    @targetViewController = targetViewController
    self.get(:time_info_label).text = '%s' % Time.at(time).strftime('%v %T %Z')
    self.get(:score_info_label).text = 'score:%-8d' % score
    self.get(:by_info_label).text = 'by:%s' % by
  end

private
  def view_button_clicked
    show_in_sfsvc do end
  end
  alias :title_label_clicked :view_button_clicked

  def show_in_sfsvc(&block)
    sfsViewController = SFSafariViewController.alloc.initWithURL(NSURL.URLWithString @url, entersReaderIfAvailable: true)
    #sfsViewController.delegate = @targetViewController | self
    sfsViewController.preferredBarTintColor = UIColor.colorWithRed(0.45, green: 0.70, blue: 0.90, alpha: 0.25)
    sfsViewController.preferredControlTintColor = UIColor.colorWithRed(0.45, green: 0.70, blue: 0.90, alpha: 0.25)

    @targetViewController.presentViewController(sfsViewController,
      animated: true,
      completion: block)
  end
end
