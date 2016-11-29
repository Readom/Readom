class StoriesLayout < MotionKit::Layout
  def layout
    # create a collection view layout object:
    flow_layout = UICollectionViewFlowLayout.alloc.init

    # set layout flow direction:
    flow_layout.scrollDirection = UICollectionViewScrollDirectionVertical

    # create a collection view with a given layout:
    collection = UICollectionView.alloc.initWithFrame CGRectZero,
      collectionViewLayout: flow_layout

    # add collection view to our layout:
    add collection, :collection
  end

  def collection_style
    constraints do
      top.equals(:superview)
      center_x.equals(:superview)
      bottom.equals(:superview)
      width.equals(:superview).minus(10)
    end

    background_color '#fff0e6'.uicolor
  end
end
