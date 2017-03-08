class WebScreen < AXWebViewController
  class <<self
    def create(params={})
      item = params[:item]
      url = params[:url]
      reader = params[:reader]

      sfsvc = self.alloc.initWithURL url, entersReaderIfAvailable: reader
      sfsvc.item = item
      sfsvc.delegate = self
      sfsvc.preferredBarTintColor = UINavigationBar.appearance.barTintColor
      sfsvc.preferredControlTintColor = UINavigationBar.appearance.tintColor

      sfsvc
    end
  end # end class method

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
