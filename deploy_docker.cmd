set args1=%1
echo %args1%
echo ${PWD}
rm -Force -Recurse _site
docker run -v "%cd%":/srv/jekyll -it jekyll/jekyll /srv/jekyll/deploy.sh --verbose
