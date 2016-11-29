class AppDelegate < PM::Delegate
  def on_load(app, options={})
    open StoriesScreen.new nav_bar: true

    UINavigationBar.appearance.tintColor = :white.uicolor
    UINavigationBar.appearance.barTintColor = [255, 102, 0].uicolor
    UINavigationBar.appearance.setTitleTextAttributes(
        NSForegroundColorAttributeName => :white.uicolor,
        NSBaselineOffsetAttributeName => 0,
        NSFontAttributeName => 'HelveticaNeue-Bold'.uifont(18)
      )
  end
end
