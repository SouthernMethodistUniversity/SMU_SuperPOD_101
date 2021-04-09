#!/bin/bash
echo $1
rm -Rf _site/*
echo ${PWD}
rm -Rf _site
docker run -v ${PWD}:/srv/jekyll -it jekyll/jekyll:stable /srv/jekyll/deploy.sh --verbose