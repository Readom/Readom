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
      x 0
      y 100
      right.equals(:superview, :right)
      bottom.equals(:superview, :bottom).minus(200)
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
    per_line = 1
    margin = 5
    first_line_scale = 2
    total = GiveMeFiveViewController::GIVE_ME_NUMBER
    lines = (total + first_line_scale - 1) / per_line

    full_width = collectionView.bounds.size.width
    per_width = full_width / per_line - margin * 1

    full_height = collectionView.bounds.size.height
    per_height = full_height / (lines + first_line_scale) - margin * 1

    indexPath.row == 0 ? [full_width, per_height * first_line_scale] : [per_width, per_height]
    [full_width, per_height]
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
    numberOfLines 2

    frame [[2, 2], ['100% - 54', '100% - 4']]
  end

  def btn_control_style
    frame [['100% - 50', 0], [50, '100%']]

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
