class AXWebViewLayout < MotionKit::Layout
  def layout
    wk = WKWebView.alloc.initWithFrame CGRectZero,
        configuration: WKWebViewConfiguration.new
    add wk, :webkit_view

    add UIView, :title_bar do
      add UIButton, :back
      add UIView, :info do
        add UILabel, :address
        add UILabel, :title
      end
      add UIButton, :yc
      add UIButton, :source
    end
  end

  def title_bar_style
    constraints do
      @normal_title_bar = top.equals(:superview)
      @hide_title_bar = bottom.equals(:superview, :top).deactivate
      @minimal_title_bar = bottom.equals(:superview, :top).plus(12).deactivate

      center_x.equals(:superview)
      height.is == 44
      width.equals(:superview)
    end

    background_color '#ff9900'.uicolor
  end

  def webkit_view_style
    constraints do
      top.equals(:title_bar, :bottom)
      center_x.equals(:superview)
      bottom.equals(:superview)
      width.equals(:superview)
    end

    background_color '#fff0e6'.uicolor
  end

  def info_style
    constraints do
      top.equals(:superview)
      left.equals(:back, :right)
      bottom.equals(:superview)
      right.equals(:yc, :left)
    end
  end

  def title_style
    constraints do
      top.equals(:superview)
      center_x.equals(:superview)
      bottom.equals(:address, :top)
      width.equals(:superview)
    end

    font 'Georgia'.uifont(12)
    text_alignment NSTextAlignmentLeft
    numberOfLines 0
  end

  def address_style
    constraints do
      height.is == 12
      center_x.equals(:superview)
      bottom.equals(:superview)
      width.equals(:superview)
    end

    font 'Georgia'.uifont(10)
    text_alignment NSTextAlignmentCenter
    numberOfLines 1
  end

  def back_style
    constraints do
      center_y.equals(:superview)
      left.equals(:superview)
      height.equals(:superview)
      width.equals(:superview, :height)
    end

    title_color :white.uicolor
    image icon_image(:awesome, :arrow_circle_left, size: 20, color: :white.uicolor)
    image icon_image(:awesome, :arrow_circle_o_left, size: 20, color: :white.uicolor), state: UIControlStateHighlighted
  end

  def source_style
    constraints do
      center_y.equals(:back)
      width.equals(:back)
      height.equals(:back)
      right.equals(:superview)
    end

    image icon_image(:foundation, :link, size: 20, color: :white.uicolor)
    image icon_image(:foundation, :link, size: 22, color: :white.uicolor), state: UIControlStateHighlighted
  end

  def yc_style
    constraints do
      center_y.equals(:back)
      width.equals(:back)
      height.equals(:back)
      right.equals(:source, :left)
    end

    image icon_image(:foundation, :social_hacker_news, size: 20, color: :white.uicolor)
    image icon_image(:foundation, :social_hacker_news, size: 22, color: :white.uicolor), state: UIControlStateHighlighted
  end

  # title bar action
  def normal_title_bar
    # -> normal
    @hide_title_bar.deactivate
    @minimal_title_bar.deactivate

    @normal_title_bar.activate

    relayout
  end

  def hide_title_bar
    # -> hide
    @normal_title_bar.deactivate
    @minimal_title_bar.deactivate

    @hide_title_bar.activate

    relayout
  end

  def minimal_title_bar
    # -> minimal
    @normal_title_bar.deactivate
    @hide_title_bar.deactivate

    @minimal_title_bar.activate

    relayout
  end

private
  def relayout
    UIView.animateWithDuration(0.3, animations: -> do
        self.view.layoutIfNeeded
      end)
  end
end
