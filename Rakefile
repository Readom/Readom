# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

$short_version = '1.0'
$version = '0.%s' % Time.now.strftime('%y%m.%d%H%M')
$version_fingerprint = '%s/%s/%s' % [$short_version, $version, `git log -1 --format='format:%h'`.strip]

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'README'
  app.identifier = 'cc.mib.README'

  app.short_version = $short_version
  app.version = $version

  app.deployment_target = '9.0'
  app.device_family = [:iphone, :ipad]
  app.interface_orientations = [:portrait, :portrait_upside_down, :landscape_left, :landscape_right]

  app.info_plist['VersionFingerprint'] = $version_fingerprint
  app.info_plist['UILaunchStoryboardName'] = 'Launch Screen'
  app.info_plist['ITSAppUsesNonExemptEncryption'] = false
  app.info_plist['UIStatusBarHidden'] = true

  app.info_plist['ReadomAPIBase'] = 'https://readom-api.herokuapp.com/news/v0/'

  app.files += Dir.glob(File.join(app.project_dir, 'lib/**/*.rb'))
  app.resources_dirs += %w(res/icons res/splash res/backgrounds)
  app.icons = Dir.glob("res/icons/*.png").map{|icon| icon.split("/").last}
  app.info_plist['BackgroudImages'] = Dir.glob("res/backgrounds/*.jpg").map{|img| img.split("/").last}

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

Motion::SettingsBundle.setup do |app|
  app.group 'Usage', footer: "Keep this ON to take advantage of 'Readers' view mode."
  app.multivalue "Default List", key: "defaultReadomList", default: :topstories,
    titles: [:New, :Top, :Best, :Show, :Ask, :Job],
    values: [:newstories, :topstories, :beststories, :showstories, :askstories, :jobstories]
  app.toggle "Reader View", key: "readerViewEnabled", default: true

  app.group 'App', footer: "Version: %s" % $version_fingerprint.split('/').join(' - '), titles: 'titles'
  app.child "Acknowledgements" do |ack|
    ack.child "CocoaPods", Title: 'CocoaPods' do end
  end
end
