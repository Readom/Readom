class StoriesCellLayout < MotionKit::Layout
  def layout
    root :cell do
      add UILabel, :title
      add UILabel, :info
      add UIImageView, :web
      add UIImageView, :comments
    end
  end

  def cell_style
    layer do
      corner_radius 7.0
      border_color 0xffe0e6.cgcolor
      border_width 0.5
      masks_to_bounds true
      #shadow_color '#000000'.cgcolor
      #shadow_opacity 0.9
      #shadow_radius 2.0
      #shadow_offset [0, 0]
    end

    background_color :white.uicolor
  end

  def title_style
    #t: 1, l: 2, b: 15, r: 1,
    constraints do
      top.equals(:superview)
      left.equals(:superview).plus(10)
      bottom.equals(:comments, :top)
      center_x.equals(:superview)
    end

    font 'HelveticaNeue-Medium'.uifont(18)
    text_color :black.uicolor
    lineBreakMode NSLineBreakByWordWrapping
    numberOfLines 0

    userInteractionEnabled true
  end

  def info_style
    # t: -, l: 4, b: 1, r: 1  h: 14
    constraints do
      height.equals(:comments)
      left.equals(:superview).plus(5)
      bottom.equals(:comments)
      right.equals(:web, :left).minus(2)
    end

    font 'Georgia'.uifont(12)
    text_color '#303f49'.uicolor
    lineBreakMode NSLineBreakByWordWrapping
    numberOfLines 1
  end

  def web_style
    constraints do
      height.equals(:comments)
      width.equals(:comments)
      bottom.equals(:superview)
      right.equals(:comments, :left).minus(10)
    end

    image icon_image(:foundation, :web, size: 20, color: '#606f79'.uicolor)

    userInteractionEnabled true
  end

  def comments_style
    constraints do
      height.is == 20
      width.is == 20
      bottom.equals(:superview)
      right.equals(:superview).minus(2)
    end

    image icon_image(:foundation, :comments, size: 20, color: '#606f79'.uicolor)

    userInteractionEnabled true
  end
end
