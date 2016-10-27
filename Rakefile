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

  app.icons = ['icons/icon-1024.png', 'icons/icon-120.png', 'icons/icon-180.png', 'icons/icon-58.png', 'icons/icon-80.png', 'icons/icon-87.png']
  app.prerendered_icon = false

  app.deployment_target = '9.0'
  app.frameworks << 'SafariServices'

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
  end
end
