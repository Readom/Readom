class ReadomSafariViewController < SFSafariViewController
  attr_accessor :item, :cell

  # SFSafariViewController delegate
  def safariViewController(controller, didCompleteInitialLoad: didLoadSuccessfully)
    #Tells the delegate that the initial URL load completed.
  end

  def safariViewController(controller, activityItemsForURL: url, title: title)
    #Tells the delegate that the user tapped an Action button.
    @fav_activity ||= FavoriteActivity.new.initWithItem(@item)
    [@fav_activity]
  end

  def safariViewControllerDidFinish(controller)
    #Tells the delegate that the user dismissed the view.
    find(@cell.contentView).animations.blink
  end
end
