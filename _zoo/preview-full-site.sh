#!/bin/sh
# Build the whole website (hand-written pages + blog + zoo) into _zoo/_fullsite/ and serve it
# at http://localhost:8000/ — this mirrors what GitHub Actions publishes.
# Usage (from the repository root or from _zoo/):   sh _zoo/preview-full-site.sh
set -e
cd "$(dirname "$0")/.."
quarto render _zoo
quarto run _zoo/_assets/remove-drafts.ts _zoo/_site
rm -rf _zoo/_fullsite
mkdir -p _zoo/_fullsite
# Build the hand-written pages and the blog with Jekyll, as GitHub does.
# --drafts also shows unpublished posts from _drafts/, so you can preview them.
bundle exec jekyll build --drafts --destination _zoo/_fullsite
mkdir -p _zoo/_fullsite/zoo
cp -R _zoo/_site/. _zoo/_fullsite/zoo/
[ "$1" = "--no-serve" ] && exit 0
echo "Serving http://localhost:8000/  (zoo at http://localhost:8000/zoo/) — Ctrl-C to stop"
cd _zoo/_fullsite && python3 -m http.server 8000
