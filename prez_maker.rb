require 'RedCloth'
file_to_parse = './sample'
output_file = './sample_output.html'
file_contents = File.read(file_to_parse)
file_contents.gsub!(/code:(.*)$/) do |match|
  "<pre class='brush: ruby;gutter: false;'>#{File.read($1.strip)}</pre>"
end
template_file_contents = File.read('./template.html')
final_html = template_file_contents.gsub(/<body>.*<\/body>/m, RedCloth.new(file_contents).to_html)
File.open(output_file,'w') {|f| f.write final_html}
