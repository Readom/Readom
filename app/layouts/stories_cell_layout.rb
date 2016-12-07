class StoriesCellLayout < MotionKit::Layout
  def layout
    root :cell do
      add UILabel, :domain
      add UILabel, :title
      add UILabel, :info
      add UIImageView, :openurl
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
      bottom.equals(:domain, :top)
      center_x.equals(:superview)
    end

    font 'HelveticaNeue-Medium'.uifont(18)
    text_color :black.uicolor
    lineBreakMode NSLineBreakByWordWrapping
    numberOfLines 0

    userInteractionEnabled true
  end

  def domain_style
    constraints do
      height.equals(:info)
      left.equals(:info)
      bottom.equals(:info, :top)
      right.equals(:openurl, :left).minus(2)
    end

    font 'Georgia'.uifont(12)
    text_color '#303f49'.uicolor
    lineBreakMode NSLineBreakByWordWrapping
    numberOfLines 1
  end

  def info_style
    # t: -, l: 4, b: 1, r: 1  h: 14
    constraints do
      height.is == 15
      left.equals(:superview).plus(5)
      bottom.equals(:comments)
      right.equals(:openurl, :left).minus(2)
    end

    font 'Georgia'.uifont(12)
    text_color '#303f49'.uicolor
    lineBreakMode NSLineBreakByWordWrapping
    numberOfLines 1
  end

  def openurl_style
    constraints do
      height.equals(:comments)
      width.equals(:comments)
      bottom.equals(:superview)
      right.equals(:comments, :left).minus(5)
    end

    image icon_image(:foundation, :link, size: 30, color: '#606f79'.uicolor)

    userInteractionEnabled true
  end

  def comments_style
    constraints do
      height.is == 30
      width.is == 30
      bottom.equals(:superview)
      right.equals(:superview).minus(2)
    end

    image icon_image(:foundation, :social_hacker_news, size: 30, color: '#606f79'.uicolor)

    userInteractionEnabled true
  end
end
