# Fixdates

This small ruby script recursively loops through a directory of images and
adjusts the exif, modified and accessed dates.

Useful if you forgot to set your digital camera's time before taking pictures.

- install exiftool (here's how to do it on a mac with homebrew)
    $ brew install exiftool
- install bundler (if you don't already have it)
    $ gem install bundler
- cd into this directory and install gems
    $ bundle install
- run the script
    $ bundle exec ./fixdate.rb dir:/path/to/images offset:60

`dir` and `offset` arguments are required. `dir` is the full path to your
directory of images and `offset` is the amount of time you want to shift, in
seconds (can be a negative or positive integer).
