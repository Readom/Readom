class WebScreen < AXWebViewController
  def self.create(params={})
    @item = params[:item]
    url = params[:url]
    reader = params[:reader]

    sfsvc = self.alloc.initWithURL url, entersReaderIfAvailable: reader
    sfsvc.delegate = self
    sfsvc.preferredBarTintColor = [255, 102, 0].uicolor
    sfsvc.preferredControlTintColor = :white.uicolor

    sfsvc
  end

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
