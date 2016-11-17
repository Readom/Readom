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
  app.version = "1.0"
  app.short_version = '0.%s' % Time.now.strftime('%Y%m%d.%H%M%S')

  app.icons = Dir.glob("resources/Icon-*.png").map{|icon| icon.split("/").last}
  app.prerendered_icon = false

  app.deployment_target = '9.0'
  app.frameworks << 'SafariServices'

  app.device_family = [:iphone, :ipad]
  app.interface_orientations = [:portrait, :portrait_upside_down, :landscape_left, :landscape_right]
  app.info_plist['UILaunchStoryboardName'] = 'LaunchScreen'
  app.info_plist['ITSAppUsesNonExemptEncryption'] = false

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
    app.codesign_certificate = MotionProvisioning.certificate(
      type: :distribution,
      platform: :ios)

    app.provisioning_profile = MotionProvisioning.profile(
      bundle_identifier: app.identifier,
      app_name: app.name,
      platform: :ios,
      type: :distribution)

    app.short_version = app.version
    app.version = '0.%s' % Time.now.strftime('%y%m%d.%H%M%S')
    app.entitlements['beta-reports-active'] = true # For TestFlight
  end
end
