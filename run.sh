#!/bin/bash
#git pull
bundle install --no-color
RACK_ENV=production bundle exec unicorn -c unicorn.rb
