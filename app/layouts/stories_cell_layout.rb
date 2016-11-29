class StoriesCellLayout < MotionKit::Layout
  def layout
    root :cell do
      add UILabel, :title
      add UILabel, :info
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
      top.equals(:superview).plus(5)
      left.equals(:superview).plus(10)
      bottom.equals(:info, :top).minus(1)
      center_x.equals(:superview)
    end

    font 'HelveticaNeue-Bold'.uifont(18)
    text_color :black.uicolor
    lineBreakMode NSLineBreakByWordWrapping
    numberOfLines 0
  end

  def info_style
    # t: -, l: 4, b: 1, r: 1  h: 14
    constraints do
      height.is == 12
      left.equals(:superview).plus(12)
      bottom.equals(:superview).minus(2)
      center_x.equals(:superview)
    end

    font 'Arial'.uifont(12)
    text_color '#000f19'.uicolor
    lineBreakMode NSLineBreakByWordWrapping
    numberOfLines 1
  end
end
