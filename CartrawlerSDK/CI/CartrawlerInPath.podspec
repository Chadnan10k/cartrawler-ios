
Pod::Spec.new do |s|

s.name         = "CartrawlerInPath"
s.version      = "3.0.13"
s.summary      = "The Cartrawler SDK"
s.description  = <<-DESC
A toolkit for car rental & ground transport
DESC

s.homepage     = "http://cartrawler.com"

s.license      = {
:type => 'Commercial',
:text => <<-LICENSE
Copyright (C) 2016 Cartrawler
LICENSE
}

s.author             = { "Cartrawler" => "" }
s.platform     = :ios
s.platform     = :ios, "8.0"
s.source       = { :git => "https://github.com/cartrawler/cartrawler-ios-build.git", :tag => "v3.0.13-CartrawlerInPath" }

s.ios.vendored_frameworks = 'CartrawlerInPath.framework'

s.requires_arc = true

end
