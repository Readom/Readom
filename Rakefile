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

  app.development do
    app.codesign_certificate = MotionProvisioning.certificate(
      type: :development,
      platform: :ios)

    app.provisioning_profile = MotionProvisioning.profile(
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
