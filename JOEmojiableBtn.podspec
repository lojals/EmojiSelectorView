Pod::Spec.new do |s|
  s.name             = "JOEmojiableBtn"
  s.version          = "4.0.0"
  s.summary          = "Option selector that can be used as reactions"

  s.description      = "Totally customizable Options (Emoji) Selector based on Reactions"

  s.homepage         = "https://github.com/lojals/JOEmojiableBtn"
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { "Jorge Ovalle" => "jroz9105@gmail.com" }
  s.source           = { :git => "https://github.com/lojals/JOEmojiableBtn.git", :tag => s.version.to_s }
  s.social_media_url = 'https://github.com/lojals'

  s.ios.deployment_target = '10.0'
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '5.0' }
  s.swift_version    = '5.0'

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'JOEmojiableBtn' => ['Pod/Assets/*.png']
  }
end
