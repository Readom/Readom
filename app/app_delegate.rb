class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)

    setup_ui

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.makeKeyAndVisible

    storyboard = UIStoryboard.storyboardWithName("main", bundle: nil)
    @window.rootViewController = storyboard.instantiateInitialViewController

    true
  end

  private

  def setup_ui
    NSThread.sleepForTimeInterval 0.6
    UIView.setAnimationDuration 0.02

    UINavigationBar.appearance.tintColor = :white.uicolor
    UINavigationBar.appearance.barTintColor = [255, 102, 0].uicolor
    UINavigationBar.appearance.setTitleTextAttributes(
        NSForegroundColorAttributeName => :white.uicolor,
        NSBaselineOffsetAttributeName => 0,
        NSFontAttributeName => 'HelveticaNeue-Bold'.uifont(18)
      )
    UINavigationBar.appearance.setBackIndicatorImage :arrow_circle_left.awesome_icon(size: 20, color: :white.uicolor)
    # UINavigationBar.appearance.setBackIndicatorTransitionMaskImage :arrow_circle_o_left.awesome_icon(size: 20, color: :white.uicolor)
  end
end
