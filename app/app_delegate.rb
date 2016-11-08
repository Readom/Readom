class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    tab_controller = UITabBarController.alloc.initWithNibName(nil, bundle:nil)
    tab_controller.viewControllers = [
      UINavigationController.alloc.initWithRootViewController(GiveMeFiveViewController.new),
      UINavigationController.alloc.initWithRootViewController(HomeViewController.new),
      UINavigationController.alloc.initWithRootViewController(StoriesViewController.new)
    ]

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = tab_controller
    @window.makeKeyAndVisible

    true
  end
end
