class HomeViewController < UIViewController
  def loadView
    self.title = "README"._

    @layout = HomeLayout.new
    self.view = @layout.view

    @action_button = @layout.action_button
  end

  def viewDidLoad
    @action_button.addTarget(self,
      action: :readom_sample,
      forControlEvents: UIControlEventTouchUpInside)
  end

private
  def readom_sample
    Readom.fetch_item_sample(:topstories) do |title, url|
      self.presentViewController(SFSafariViewController.alloc.initWithURL(NSURL.URLWithString url, entersReaderIfAvailable: true),
        animated: true,
        completion: nil)
    end
  end
end
