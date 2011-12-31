require 'erb'
require 'RedCloth'

def get_snippet(location)
 file_name, snippet_tag = location.split(':')
 snippet_tag ? File.read(file_name).match(/--#{snippet_tag}--\n(?<snippet>.*)#--#{snippet_tag}--\n/m)[:snippet] : File.read(file_name)
end

file_name_to_process = ARGV.shift
p 'Give valid file name' and exit unless file_name_to_process && File.exist?(file_name_to_process)
output_file = "#{file_name_to_process.chomp(File.extname(file_name_to_process))}_out.html"
file_contents = File.read(file_name_to_process)
file_contents.gsub!(/code:(.*)$/) do |match|
  "<pre class='brush: ruby;gutter: false;'>#{get_snippet($1.strip)}</pre>"
end
slides = file_contents.split(/^>>>>>>>>>.*\n/).collect{|raw_slide| RedCloth.new(raw_slide).to_html}
final_html = ERB.new(File.read('./template.html.erb')).result(binding)
File.open(output_file,'w') {|f| f.write final_html}
puts "Check #{output_file}"
puts 'Done.'
