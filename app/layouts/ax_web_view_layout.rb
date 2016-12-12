class AXWebViewLayout < MotionKit::Layout
  def layout
    wk = WKWebView.alloc.initWithFrame CGRectZero,
        configuration: WKWebViewConfiguration.new
    add wk, :webkit_view
  end

  def webkit_view_style
    constraints do
      top.equals(:superview)
      center_x.equals(:superview)
      bottom.equals(:superview)
      width.equals(:superview)
    end

    background_color '#fff0e6'.uicolor
  end
end
