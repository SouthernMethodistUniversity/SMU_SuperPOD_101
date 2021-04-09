#!/bin/bash

python bin/lesson_initialize.py

bundle exec jekyll build
bundle exec jekyll server
