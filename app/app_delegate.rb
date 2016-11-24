class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    tab_controller = UITabBarController.alloc.initWithNibName(nil, bundle:nil)
    tab_controller.viewControllers = [
      UINavigationController.alloc.initWithRootViewController(GiveMeFiveViewController.new),
      UINavigationController.alloc.initWithRootViewController(MiuViewController.new)
    ]

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = tab_controller
    @window.makeKeyAndVisible

    UITabBar.appearance.setTintColor UIColor.colorWithRed(0.25, green: 0.40, blue: 0.60, alpha: 1.0)
    UITabBar.appearance.setBarTintColor UIColor.whiteColor
    UINavigationBar.appearance.setTitleTextAttributes(NSForegroundColorAttributeName => UIColor.colorWithRed(0.35, green: 0.60, blue: 0.80, alpha: 1.0))

    true
  end
end
