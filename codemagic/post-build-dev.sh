#!/usr/bin/env sh

set -e # exit on first failed commandset

source pre-build-dev.sh

#bundle exec fastlane android qa
bundle exec fastlane ios qa