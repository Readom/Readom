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
    Readom.fetch_item_sample(:topstories) do |id, title, url|
      self.presentViewController(SFSafariViewController.alloc.initWithURL(NSURL.URLWithString url, entersReaderIfAvailable: true),
        animated: true,
        completion: nil)
    end
  end
end
