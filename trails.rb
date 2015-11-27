#!/usr/bin/env ruby

require 'fileutils'
include FileUtils


dir = ARGV.shift
method = ARGV.shift
if dir.nil? || method.nil?
  puts "usage #{$0} <image-dir> <method>"
  dir = "."
  method = "lightenIntensity"
end

out_path = "method_#{method}.jpg"
tmp_path = 'tmp.jpg'

files = Dir.glob(File.join(dir, '*.jpg'))
cp(files.pop, out_path)

offset = 1.to_f
files.each do |path|
  print "%s\t%2.0f%%\r" % [File.basename(path), 100*offset/files.size]
  offset += 1

  out = `composite "#{path}" "#{out_path}" -compose #{method} "#{tmp_path}" 2>&1`
  raise "error composing image: #{out}" unless $?.success?

  mv(tmp_path, out_path)
end