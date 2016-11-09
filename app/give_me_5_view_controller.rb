class GiveMeFiveViewController < UIViewController
  GIVE_ME_NUMBER = 5

  def initWithNibName(name, bundle: bundle)
    super
    self.title = "GiveMeFive"._
    self.tabBarItem = UITabBarItem.alloc.initWithTitle("Give Me 5"._, image: nil, tag: 0)

    self
  end

  def loadView
    @layout = GiveMeFiveLayout.new
    self.view = @layout.view
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

  def layout
    background_color UIColor.colorWithRed(0.81, green: 0.91, blue: 0.86, alpha: 1.0)

    add UIButton, :action_button

    flow_layout = UICollectionViewFlowLayout.alloc.init
    flow_layout.scrollDirection = UICollectionViewScrollDirectionVertical
    collection = UICollectionView.alloc.initWithFrame CGRectZero, collectionViewLayout: flow_layout
    add collection, :collection
  end

  def action_button_style
    title "GiveMeFive"._
    size_to_fit

    addTarget(self,
      action: :set_data,
      forControlEvents: UIControlEventTouchUpInside)

    center ['50%', '100% - 100']
  end

  def collection_style
    background_color UIColor.colorWithRed(0.91, green: 0.96, blue: 0.96, alpha: 0.8)

    constraints do
      left.equals(:superview, :left)
      right.equals(:superview, :right)
      top.equals(:superview, :top).plus(70)
      bottom.equals(:superview, :bottom).minus(180)
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
    cell.set(title, url, collectionView)

    cell
  end

  def collectionView(collectionView, layout: layout, sizeForItemAtIndexPath: indexPath)
    full_width = collectionView.bounds.size.width
    full_height = collectionView.bounds.size.height

    per_line = 1
    margin = 10
    first_line_scale = {:x => 1, :y => 2}
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

  def set(title, url, collectionView)
    @layout.set(title, url, collectionView)
  end
end

class GiveMeFiveCollectionCellLayout < MK::Layout
  @url = nil
  @collectionView = nil

  def layout
    root :cell do
      add UILabel, :title_label, z_index: 1
      add UIButton, :btn_control, z_index: 2
    end
  end

  def cell_style
    background_color UIColor.whiteColor
  end

  def title_label_style
    text_color UIColor.grayColor
    lineBreakMode NSLineBreakByWordWrapping
    numberOfLines 3

    constraints do
      left.equals(:superview, :left).plus(1)
      right.equals(:superview, :right).plus(-55)
      top.equals(:superview, :top)
      bottom.equals(:superview, :bottom)
    end
  end

  def btn_control_style
    constraints do
      #left.equals(:superview, :right).plus(-55)
      left.equals(:title_label, :right).plus(1)
      right.equals(:superview, :right)
      top.equals(:superview, :top)
      bottom.equals(:superview, :bottom)
    end

    title 'View'

    background_color UIColor.colorWithRed(0.81, green: 0.76, blue: 0.86, alpha: 0.8)

    #addTarget(self,
    #  action: :btn_clicked,
    #  forControlEvents: UIControlEventTouchUpInside)
  end

  def set(title, url, collectionView)
    @url = url
    self.get(:title_label).text = title
    @collectionView = collectionView
  end
end