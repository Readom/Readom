class WebScreen < SFSafariViewController

  def self.create(url)
    sfsvc = self.alloc.initWithURL url.nsurl, entersReaderIfAvailable: true
    sfsvc.delegate = self
    sfsvc.preferredBarTintColor = UINavigationBar.appearance.barTintColor
    sfsvc.preferredControlTintColor = UINavigationBar.appearance.tintColor

    sfsvc
  end

  attr_accessor :url, :delegate

  # SFSafariViewController delegate
  def safariViewController(controller, didCompleteInitialLoad: didLoadSuccessfully)
    #Tells the delegate that the initial URL load completed.
  end

  def safariViewController(controller, activityItemsForURL: url, title: title)
    #Tells the delegate that the user tapped an Action button.
  end

  def safariViewControllerDidFinish(controller)
    #Tells the delegate that the user dismissed the view.
  end

  def prefersStatusBarHidden
    true
  end

end
