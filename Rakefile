# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'README'
  app.identifier = 'cc.mib.README'

  app.short_version = '1.0'
  app.version = '0.%s' % Time.now.strftime('%y%m.%d%H%M')

  app.deployment_target = '9.0'
  app.device_family = [:iphone, :ipad]
  app.interface_orientations = [:portrait, :portrait_upside_down, :landscape_left, :landscape_right]

  app.info_plist['VersionFingerprint'] = '%s/%s/%s' % [app.short_version, app.version, `git log -1 --format='format:%h'`.strip]
  app.info_plist['UILaunchStoryboardName'] = 'LaunchScreen'
  app.info_plist['ITSAppUsesNonExemptEncryption'] = false
  app.info_plist['UIStatusBarHidden'] = true

  app.files += Dir.glob(File.join(app.project_dir, 'lib/**/*.rb'))
  app.resources_dirs += %w(res/icons res/splash res/backgrounds)
  app.icons = Dir.glob("res/icons/*.png").map{|icon| icon.split("/").last}
  app.info_plist['BackgroudImages'] = Dir.glob("res/backgrounds/*.jpg").map{|img| img.split("/").last}

  app.frameworks << 'SafariServices'

  app.pods do
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

    app.entitlements['beta-reports-active'] = true

    # app.seed_id = "YOUR_SEED_ID"
    app.entitlements['application-identifier'] = app.seed_id + '.' + app.identifier
    app.entitlements['keychain-access-groups'] = [ app.seed_id + '.' + app.identifier ]
  end

  puts "Name: #{app.name}"
  puts "Using profile: #{ENV['TRAVIS'] ? nil : app.provisioning_profile}"
  puts "Using certificate: #{ENV['TRAVIS'] ? nil : app.codesign_certificate}"
end
