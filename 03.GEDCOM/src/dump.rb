require 'nokogiri'
require File.join(File.expand_path(File.dirname(__FILE__)), "..", "src", "ged")

input = File.join(File.expand_path(File.dirname(__FILE__)), "..", "royal.ged")

doc = GedComDoc.new
parser = GedComParser.new( doc ).parse( File.new( input ) )
puts doc.to_xml.to_s

