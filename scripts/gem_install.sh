#!/bin/bash
PKG_VERSION="2.7.6"
printf "$PKG_VERSION" >> .ruby-lock

gem install bundler

bundle -v

touch Gemfile Gemfile.lock

echo ".bundle" >> .gitignore
git add Gemfile Gemfile.lock .gitignore
git commit -m "Add Bundler support"

# bundle gem foodie

# spec.add_development_dependency "cocoapods", "~> 1.11", ">= 1.11.2"

# spec.add_development_dependency "fastlane", "~> 3.2"

# spec.add_development_dependency "json", "~> 3.2"

source "https://rubygems.org"

bundle add fastlane
bundle add json
bundle add cocoapods

bundle install

bundle update
