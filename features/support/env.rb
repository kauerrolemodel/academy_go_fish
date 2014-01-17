require_relative '../../go_fish_app'

require 'rspec'
require 'rspec/expectations'
require 'spinach/capybara'
Spinach::FeatureSteps.send(:include, Spinach::FeatureSteps::Capybara)
Capybara.app = GoFishApp

