class GiveMeFiveViewController < UIViewController
  GIVE_ME_NUMBER = 5

  def initWithNibName(name, bundle: bundle)
    super
    self.title = "GiveMeFive"._
    self.tabBarItem = UITabBarItem.alloc.initWithTitle("Give Me 5"._, image: nil, tag: 0)
    self.edgesForExtendedLayout = UIRectEdgeNone

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
      bottom.equals(:superview)
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
      top.equals(:superview, :top)
      bottom.equals(:action_button, :top).minus(3)
    end

    dataSource self
    delegate self
    registerClass GiveMeFiveCollectionCell, forCellWithReuseIdentifier: GiveMeFiveCollectionCell::IDENTIFIER

    set_data unless @data
  end

private
  def set_data
    @data = []
    Readom.fetch_items(:newstories, GiveMeFiveViewController::GIVE_ME_NUMBER) do |id, title, url|
      @data << [id, title, url]

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
    id, title, url = @data[indexPath.row]
    cell.set(title, url, @vc)

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

  def set(title, url, targetViewController)
    @layout.set(title, url, targetViewController)
  end
end

class GiveMeFiveCollectionCellLayout < MK::Layout
  @url = nil
  @targetViewController = nil

  def layout
    root :cell do
      add UILabel, :title_label, z_index: 1
      add UIButton, :view_button, z_index: 2
    end
  end

  def cell_style
    background_color UIColor.whiteColor
  end

  def title_label_style
    text_color UIColor.colorWithRed(0.25, green: 0.25, blue: 0.25, alpha: 0.5)
    lineBreakMode NSLineBreakByWordWrapping
    numberOfLines 0

    constraints do
      left.equals(:superview, :left).plus(2)
      right.equals(:superview, :right).minus(55)
      top.equals(:superview, :top)
      bottom.equals(:superview, :bottom)
    end

    userInteractionEnabled  true
    tapGesture = UITapGestureRecognizer.alloc.initWithTarget(self, action: :view_button_clicked)
    tapGesture.numberOfTapsRequired = 2
    addGestureRecognizer(tapGesture)
  end

  def view_button_style
    background_color UIColor.colorWithRed(0.45, green: 0.70, blue: 0.90, alpha: 0.75)
    title_color UIColor.whiteColor

    title 'VIEW'._
    size_to_fit

    constraints do
      left.equals(:title_label, :right).plus(1)
      right.equals(:superview, :right)
      top.equals(:superview, :top)
      bottom.equals(:superview, :bottom)
    end

    addTarget(self,
      action: :view_button_clicked,
      forControlEvents: UIControlEventTouchUpInside)
  end

  def set(title, url, targetViewController)
    @url = url
    self.get(:title_label).text = title
    @targetViewController = targetViewController
  end

private
  def view_button_clicked
    show_in_sfsvc do end
  end
  alias :title_label_clicked :view_button_clicked

  def show_in_sfsvc(&block)
    sfsViewController = SFSafariViewController.alloc.initWithURL(NSURL.URLWithString @url, entersReaderIfAvailable: true)
    #sfsViewController.delegate = @targetViewController | self

    @targetViewController.presentViewController(sfsViewController,
      animated: true,
      completion: block)
  end
end
