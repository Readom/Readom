# -*- coding: utf-8 -*-
$:.unshift('/Library/RubyMotion/lib')
require 'motion/project/template/ios'

require 'bundler'
Bundler.require

# require 'bubble-wrap'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings

  app.name = 'README'
  app.identifier = 'cc.mib.README'

  app.short_version = '1.0.3'
  # Get version from git
  #app.version = (`git rev-list HEAD --count`.strip.to_i).to_s
  #app.version = `git log -1 --format='format:%h'`.strip
  #app.version = app.short_version
  app.version = '0.%s' % Time.now.strftime('%y%m.%d%H%M')

  app.info_plist['VersionFingerprint'] = '%s/%s/%s' % [app.short_version, app.version, `git log -1 --format='format:%h'`.strip]

  # RubyMotion by default selects the latest SDK you have installed,
  # if you would like to specify the SDK to assure consistency across multiple machines,
  # you can do so like the following examples
  # app.sdk_version = '8.3'
  # app.sdk_version = '7.1'

  # Target OS - Set this to the lowest version you want to support in the App Store
  # app.deployment_target = '7.1'
  # app.deployment_target = '8.0'
  app.deployment_target = '9.0'

  app.resources_dirs += %w(resources/icons resources/splash resources/backgrounds)
  app.icons = Dir.glob("resources/icons/*.png").map{|icon| icon.split("/").last}

  app.device_family = [:iphone, :ipad]
  app.interface_orientations = [:portrait, :portrait_upside_down, :landscape_left, :landscape_right]
  app.info_plist['UILaunchStoryboardName'] = 'LaunchScreen'
  app.info_plist['ITSAppUsesNonExemptEncryption'] = false
  app.info_plist['UIStatusBarHidden'] = true

  app.files += Dir.glob(File.join(app.project_dir, 'lib/**/*.rb'))

  # app.fonts = ['Oswald-Regular.ttf', 'FontAwesome.otf'] # These go in /resources
  # Or use all *.ttf fonts in the /resources/fonts directory:
  # app.fonts = Dir.glob("resources/fonts/*.ttf").map{|font| "fonts/#{font.split('/').last}"}
  # app.frameworks += %w(QuartzCore CoreGraphics MediaPlayer MessageUI CoreData)
  app.frameworks << 'SafariServices'

  # app.vendor_project('vendor/Flurry', :static)
  # app.vendor_project('vendor/DSLCalendarView', :static, :cflags => '-fobjc-arc') # Using arc

  app.pods do
    pod 'SDWebImage'
  #   pod 'JGProgressHUD'
  #   pod 'SVProgressHUD'
  #   pod "FontasticIcons"
    pod 'CWStatusBarNotification'
  end

  app.development do
    app.codesign_certificate = ENV['TRAVIS'] ? nil : MotionProvisioning.certificate(
      type: :development,
      platform: :ios)

    app.provisioning_profile = ENV['TRAVIS'] ? nil : MotionProvisioning.profile(
      bundle_identifier: app.identifier,
      app_name: app.name,
      platform: :ios,
      type: :development)
  end

  app.release do
    app.entitlements['get-task-allow'] = false
    app.codesign_certificate = MotionProvisioning.certificate(
      type: :distribution,
      platform: :ios)

    app.provisioning_profile = MotionProvisioning.profile(
      bundle_identifier: app.identifier,
      app_name: app.name,
      platform: :ios,
      type: :distribution)

    app.entitlements['beta-reports-active'] = true # For TestFlight

    # app.seed_id = "YOUR_SEED_ID"
    app.entitlements['application-identifier'] = app.seed_id + '.' + app.identifier
    app.entitlements['keychain-access-groups'] = [ app.seed_id + '.' + app.identifier ]
  end

  puts "Name: #{app.name}"
  puts "Using profile: #{ENV['TRAVIS'] ? nil : app.provisioning_profile}"
  puts "Using certificate: #{ENV['TRAVIS'] ? nil : app.codesign_certificate}"
end

# Remove this if you aren't using CDQ
task :"build:simulator" => :"schema:build"
