# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

$short_version = '1.3'
$version = '0.%s' % Time.now.strftime('%y%m.%d%H%M')
$version_fingerprint = '%s/%s/%s' % [$short_version, $version, `git log -1 --format='format:%h'`.strip]

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.

  define_icon_defaults!(app)
  force_64bit_only!(app)

  # name of your app that will show on up the device
  app.name = 'README'

  # version for your app
  app.version = $version
  app.short_version = $short_version
  app.info_plist['VersionFingerprint'] = $version_fingerprint

  # you'll want to target the lowest version of the sdk that supports the apis you're leveraging. RubyMotion Starter can only target the lastest iOS SDK.
  # app.deployment_target = '9.0'

  # before deploying to the app store you'll need an app identifier (which can be set up via https://developer.apple.com/account/ios/identifier/bundle)
  app.identifier = 'cc.mib.README'

  # add additional frameworks here
  # app.frameworks << "StoreKit"
  app.frameworks << 'SafariServices'
  app.frameworks << 'WebKit'

  # resonable defaults
  app.device_family = [:iphone, :ipad]
  app.interface_orientations = [:portrait, :portrait_upside_down, :landscape_left, :landscape_right]
  app.info_plist['UIRequiresFullScreen'] = true
  app.info_plist['ITSAppUsesNonExemptEncryption'] = false
  app.info_plist['UIStatusBarHidden'] = true

  app.development do
    # Dev, create a development certificate at: https://developer.apple.com/account/ios/certificate/development
    # app.codesign_certificate = ''
    # app.provisioning_profile = ''
  end

  app.release do
    app.entitlements['get-task-allow'] = false
    app.entitlements['application-identifier'] = app.seed_id + '.' + app.identifier
    app.entitlements['keychain-access-groups'] = [ app.seed_id + '.' + app.identifier ]

    # Production, create a production certificate at:
    # https://developer.apple.com/account/ios/certificate/distribution.
    # These values will need to be set to before you can deploy to the
    # App Store. Compile using `rake clean archive:distribution` and
    # upload the .ipa under ./build using Application Loader.

    # app.codesign_certificate = ''
    # app.provisioning_profile = ''

    # TestFlight: this flag needs to be set if you want to distribute
    # TestFlight builds. It is strongly recommend that you do a
    # TestFlight build and run on a device before doing a release build
    # for App Store consumption.
    app.entitlements['beta-reports-active'] = true
  end
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

def define_icon_defaults!(app)
  # This is required as of iOS 11.0 (you must use asset catalogs to
  # define icons or your app will be regected. More information in
  # located in the readme.

  app.info_plist['CFBundleIcons'] = {
    'CFBundlePrimaryIcon' => {
      'CFBundleIconName' => 'AppIcon',
      'CFBundleIconFiles' => ['AppIcon60x60']
    }
  }

  app.info_plist['CFBundleIcons~ipad'] = {
    'CFBundlePrimaryIcon' => {
      'CFBundleIconName' => 'AppIcon',
      'CFBundleIconFiles' => ['AppIcon60x60', 'AppIcon76x76']
    }
  }
end

def force_64bit_only!(app)
  # This is required as of iOS 11.0, 32 bit compilations will no
  # longer be allowed for submission to the App Store.

  app.archs['iPhoneOS'] = ['arm64']
  app.info_plist['UIRequiredDeviceCapabilities'] = ['arm64']
end
