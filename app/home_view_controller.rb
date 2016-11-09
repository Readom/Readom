class HomeViewController < UIViewController
  def initWithNibName(name, bundle: bundle)
    super
    self.title = "README"._
    self.tabBarItem = UITabBarItem.alloc.initWithTitle("README"._, image: nil, tag: 0)

    self
  end

  def loadView
    @layout = HomeLayout.new
    self.view = @layout.view
  end

  def viewDidLoad
    @layout.action_button.addTarget(self,
      action: :readom_sample,
      forControlEvents: UIControlEventTouchUpInside)
  end

private
  def readom_sample
    Readom.fetch_items(:topstories, 1) do |id, title, url|
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
