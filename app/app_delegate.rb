class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    tab_controller = UITabBarController.alloc.initWithNibName(nil, bundle:nil)
    tab_controller.viewControllers = [
      UINavigationController.alloc.initWithRootViewController(HomeViewController.new),
      UINavigationController.alloc.initWithRootViewController(GiveMeFiveViewController.new),
      UINavigationController.alloc.initWithRootViewController(StoriesViewController.new)
    ]

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = tab_controller
    @window.makeKeyAndVisible

    set_style()

    true
  end

private
  def set_style
    UITabBar.appearance.setTintColor UIColor.yellowColor
    UITabBar.appearance.setBarTintColor UIColor.colorWithRed(0.45, green: 0.70, blue: 0.90, alpha: 1.0)
    UITabBar.appearance.setBarStyle UIBarStyleBlack
    UINavigationBar.appearance.setTitleTextAttributes(NSForegroundColorAttributeName => UIColor.colorWithRed(0.45, green: 0.70, blue: 0.90, alpha: 1.0))
  end
end
