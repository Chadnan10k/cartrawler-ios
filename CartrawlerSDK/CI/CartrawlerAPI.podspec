
Pod::Spec.new do |s|

s.name         = "CartrawlerAPI"
s.version      = "2.0.2"
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
s.source       = { :git => "https://github.com/cartrawler/cartrawler-ios-build.git", :tag => "v2.0.2-CartrawlerAPI" }

s.ios.vendored_frameworks = 'CartrawlerAPI.framework'

s.requires_arc = true

end
