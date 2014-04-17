#!/usr/bin/env ruby

require 'time'
require 'mini_exiftool'

# loop through files in current directory and reset the date
args = {}

ARGV.each do |a|
  a = a.split ':'
  if a.length == 2
    args[a[0].to_sym] = a[1]
  else
    raise "Invalid argument - parameters must be passed in as key:value"
  end
end

raise "dir must be defined" unless args[:dir]
raise "offset (in seconds) must be defined" unless args[:offset]

raise "#{args[:dir]} is not a directory" unless File.directory?(args[:dir])

fmt = '%Y-%m-%d %H:%M:%S'
delta = args[:offset].to_i

Dir.chdir args[:dir] do
  Dir.glob("**/*").map do |path|
    if File.file?(path)
      begin
        photo = MiniExiftool.new path
      rescue MiniExiftool::Error => e
        p e.message
        next
      end
      time = photo.date_time_original
      new_time = time + delta
      photo.date_time_original = new_time
      # update the exif data
      if photo.save
        # update the last modified / accessed times
        File.utime(new_time, new_time, path)
        p "#{path} changed: #{time.strftime(fmt)} -> #{new_time.strftime(fmt)}"
      else
        p "could not change #{path}"
      end
    end
  end
end
