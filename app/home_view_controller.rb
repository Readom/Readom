class HomeViewController < UIViewController
  def loadView
    self.title = "README"._

    @layout = HomeLayout.new
    self.view = @layout.view

    @action_button = @layout.action_button
  end

  def viewDidLoad
    @action_button.addTarget(self,
      action: nil,
      forControlEvents: UIControlEventTouchUpInside)
  end
end
