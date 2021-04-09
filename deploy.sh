#!/bin/bash

bundle install
bundle exec jekyll build
bundle exec jekyll server
