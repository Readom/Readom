class StoriesCellLayout < MotionKit::Layout
  def layout
    root :cell do
      add UILabel, :domain

      add UIView, :title_container do
        add UILabel, :title

        add UIView, :score_view do
          add UIImageView, :score_title
          add UILabel, :score_number
        end
      end

      add UIView, :info_container do
        add UILabel, :time_ago

        add UIImageView, :url_button
        add UIImageView, :yc_button
      end
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

  # cell -> domain
  def domain_style
    constraints do
      top.equals(:superview).plus(2)
      left.equals(:superview).plus(10)
      height.is == 15
      center_x.equals(:superview)
    end

    text_alignment NSTextAlignmentRight

    font 'Georgia'.uifont(12)
    text_color '#303f49'.uicolor
    lineBreakMode NSLineBreakByWordWrapping
    numberOfLines 1
  end

  # cell -> title_container
  def title_container_style
    constraints do
      top.equals(:domain, :bottom)
      left.equals(:domain)
      right.equals(:domain)
      bottom.equals(:info_container, :top)
    end
  end

  # cell -> info_container
  def info_container_style
    constraints do
      height.is(30)
      left.equals(:domain)
      bottom.equals(:superview).minus(2)
      right.equals(:domain)
    end
  end

  # cell -> title_container -> title
  def title_style
    #t: 1, l: 2, b: 15, r: 1,
    constraints do
      top.equals(:superview)
      left.equals(:superview)
      bottom.equals(:superview)
      right.equals(:score_view, :left).minus(2)
    end

    font 'HelveticaNeue-Medium'.uifont(18)
    text_color :black.uicolor
    lineBreakMode NSLineBreakByWordWrapping
    numberOfLines 0

    userInteractionEnabled true
  end

  # cell -> title_container -> score_view
  def score_view_style
    layer do
      corner_radius 7.0
      border_color 0xffe0e6.cgcolor
      border_width 0.5
      masks_to_bounds true
    end

    constraints do
      width.is == 32
      height.is == 50
      center_y.equals(:superview)
      right.equals(:superview, :right)
    end
  end

  # cell -> title_container -> score_view -> score_title
  def score_title_style
    constraints do
      width.equals(:superview,)
      height.equals(:superview, :width)
      top.equals(:superview)
      center_x.equals(:superview)
    end

    image icon_image(:foundation, :like, size: 30, color: :white.uicolor)
    background_color '#ff9900'.uicolor
  end

  # cell -> title_container -> score_view -> score_number
  def score_number_style
    constraints do
      top.equals(:score_title, :bottom)
      center_x.equals(:superview)
      bottom.equals(:superview)
      width.equals(:superview)
    end

    text_color '#ff9900'.uicolor
    text_alignment NSTextAlignmentCenter
    lineBreakMode NSLineBreakByWordWrapping
    numberOfLines 1
  end

  # cell -> info_container
  def time_ago_style
    # t: -, l: 4, b: 1, r: 1  h: 14
    constraints do
      height.is == 15
      left.equals(:superview)
      center_y.equals(:url_button)
      right.equals(:yc_button, :left).minus(2)
    end

    font 'Georgia'.uifont(12)
    text_color '#303f49'.uicolor
    lineBreakMode NSLineBreakByWordWrapping
    numberOfLines 1
  end

  # cell -> info_container -> yc_button
  def yc_button_style
    constraints do
      height.equals(:url_button)
      width.equals(:url_button)
      center_y.equals(:url_button)
      right.equals(:url_button, :left).minus(5)
    end

    image icon_image(:foundation, :social_hacker_news, size: 30, color: '#505f69'.uicolor)

    userInteractionEnabled true
  end

  # cell -> info_container -> url_button
  def url_button_style
    constraints do
      height.equals(:superview, :height)
      width.equals(:superview, :height)
      center_y.equals(:superview)
      right.equals(:superview)
    end

    image icon_image(:foundation, :link, size: 30, color: '#505f69'.uicolor)

    userInteractionEnabled true
  end
end
