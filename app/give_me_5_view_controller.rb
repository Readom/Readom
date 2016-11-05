class GiveMe5ViewController < UIViewController
  def initWithNibName(name, bundle: bundle)
    super
    self.title = "GiveMe5"._
    self.tabBarItem = UITabBarItem.alloc.initWithTitle("Give Me 5"._, image: nil, tag: 0)

    self
  end

  def loadView
    @layout = GiveMe5Layout.new
    self.view = @layout.view
  end

  def viewDidLoad
    super

    @layout.action_button.addTarget(self,
      action: :give_me_5,
      forControlEvents: UIControlEventTouchUpInside)
  end

  def viewDidAppear(animated)
    super
  end

private
  def give_me_5
    puts 'give me 5 '
  end
end

class GiveMe5Layout < MotionKit::Layout
  view :action_button

  def layout
    background_color UIColor.colorWithRed(0.81, green: 0.91, blue: 0.86, alpha: 1.0)

    add UIButton, :action_button
  end

  def action_button_style
    title "GiveMe5"._
    size_to_fit

    center ['50%', '100% - 100']
  end
end
