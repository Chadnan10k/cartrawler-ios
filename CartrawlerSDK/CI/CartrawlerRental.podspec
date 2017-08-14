
Pod::Spec.new do |s|

s.name         = "CartrawlerRental"
s.version      = "4.0.18"
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
s.source       = { :git => "https://github.com/cartrawler/cartrawler-ios-build.git", :tag => "v4.0.18-CartrawlerRental" }

s.ios.vendored_frameworks = 'CartrawlerRental.framework'

s.requires_arc = true

end
