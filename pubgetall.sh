#! /bin/sh

for dir in */; do
  (
    cd "$dir"
    flutter pub get
  )
done
