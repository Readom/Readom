class HomeLayout < MotionKit::Layout
  view :action_button, :action_label

  def layout
    background_color UIColor.whiteColor

    add UIButton, :action_button
    add UILabel, :action_label
  end

  def action_button_style
    background_image UIImage.imageNamed('icons/icon-180.png'), state:UIControlStateNormal
    size_to_fit

    center ['50%', '50% - 90']
  end

  def action_label_style
    text "README:Go"._
    background_color UIColor.whiteColor
    size_to_fit

    frame below(:action_button, down: 0)
  end
end
