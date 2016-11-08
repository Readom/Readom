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
    background_color UIColor.colorWithRed(0.71, green: 0.71, blue: 0.76, alpha: 1.0)

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
    per_line = 2
    margin = 5
    full_width = collectionView.bounds.size.width
    per_width = full_width / per_line - margin * 1

    full_height = collectionView.bounds.size.height
    per_height = full_height / 4 - margin * 1

    indexPath.row == 0 ? [full_width, per_height * 2] : [per_width, per_height]
  end

  def set_data
    @data = []
    Readom.fetch_items(:newstories, GiveMeFiveViewController::GIVE_ME_NUMBER) do |id, title, url|
      @data << [id, title, url]

      self.collection.reloadData
    end
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
  view :title

  @url = nil
  @collectionView = nil

  def layout
    root :cell do
      add UILabel, :title, z_index: 1
      add UIButton, :btn_control, z_index: 2
    end
  end

  def cell_style
    background_color UIColor.whiteColor
  end

  def title_style
    text_color UIColor.grayColor
    lineBreakMode NSLineBreakByWordWrapping
    numberOfLines 2

    x 2
    y 0
    width '100% - 5'
    height '100% - 25'
  end

  def btn_control_style
    x 0
    y 0
    width '100%'
    height '100%'

    #addTarget(self,
    #  action: :btn_clicked,
    #  forControlEvents: UIControlEventTouchUpInside)
  end

  def set(title, url, collectionView)
    @url = url
    self.get(:title).text = title
    @collectionView = collectionView
  end
end
