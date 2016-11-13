class MiuViewController < UIViewController
  def initWithNibName(name, bundle: bundle)
    super
    self.title = "README"._
    self.tabBarItem = UITabBarItem.alloc.initWithTitle(""._, image: UIImage.imageNamed("tabbar/One-Finger-50.png"), tag: 0)
    self.edgesForExtendedLayout = UIRectEdgeAll

    self
  end

  def loadView
    @layout = MiuLayout.new
    self.view = @layout.view
  end

  def viewDidLoad
    @layout.action_button.addTarget(self,
      action: :readom_sample,
      forControlEvents: UIControlEventTouchUpInside)
  end

private
  def readom_sample
    Readom.fetch_items(:newstories, 1) do |id, title, url, by, score, time|
      show(url)
    end
  end

  def show(url, &block)
    sfsView = SFSafariViewController.alloc.initWithURL(NSURL.URLWithString url, entersReaderIfAvailable: true)
    sfsView.delegate = self
    self.presentViewController(sfsView,
      animated: true,
      completion: block)
  end

  # Delegate SFSafariViewController
  def safariViewController(controller, didCompleteInitialLoad:didLoadSuccessfully)
    #Tells the delegate that the initial URL load completed.
    #puts 'sfsView loaded' if didLoadSuccessfully
  end

  def safariViewController(controller, activityItemsForURL:url, title:title)
    #Tells the delegate that the user tapped an Action button.
    #puts 'Action button tapped: url %s, title %s' % [url, title]
    #return an array of UIActivityViewController
  end

  def safariViewControllerDidFinish(controller)
    #Tells the delegate that the user dismissed the view.
    #puts 'sfsView closed'
  end
  # end Delegate
end

class MiuLayout < MotionKit::Layout
  view :action_button, :action_label

  def layout
    background_color UIColor.colorWithRed(0.90, green: 0.95, blue: 0.95, alpha: 1.0)

    add UIButton, :action_button
    add UILabel, :action_label
  end

  def action_button_style
    background_image UIImage.imageNamed('icons/icon-180.png'), state:UIControlStateNormal
    size_to_fit

    constraints do
      center_x.equals(:superview)
      center_y.equals(:superview).minus(90)
    end
  end

  def action_label_style
    textColor UIColor.colorWithRed(0.45, green: 0.70, blue: 0.90, alpha: 1.0)
    shadowColor UIColor.colorWithRed(0.45, green: 0.70, blue: 0.90, alpha: 0.75)
    shadowOffset [1, -1]

    textAlignment NSTextAlignmentCenter
    text "README:Go"._
    size_to_fit

    constraints do
      top.equals(:action_button, :bottom).plus(10)
      left.equals(:action_button)
      right.equals(:action_button)
    end
  end
end
