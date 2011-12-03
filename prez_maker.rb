require 'erb'
require 'RedCloth'

def get_snippet(location)
 file_name, snippet_tag = location.split(':')
 snippet_tag ? File.read(file_name).match(/--#{snippet_tag}--\n(?<snippet>.*)#--#{snippet_tag}--\n/m)[:snippet] : File.read(file_name)
end

file_to_parse = './sample_input.html'
output_file = './sample_output.html'
file_contents = File.read(file_to_parse)
file_contents.gsub!(/code:(.*)$/) do |match|
  "<pre class='brush: ruby;gutter: false;'>#{get_snippet($1.strip)}</pre>"
end
slides = file_contents.split(/^>>>>>>>>>.*\n/).collect{|raw_slide| RedCloth.new(raw_slide).to_html}
slides.each{|s| p s}
final_html = ERB.new(File.read('./template.html.erb')).result(binding)
File.open(output_file,'w') {|f| f.write final_html}
