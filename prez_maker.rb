require 'RedCloth'
file_to_parse = './sample'
output_file = './sample_output.html'
file_contents = File.read(file_to_parse)
file_contents.gsub!(/code:(.*)$/) do |match|
  "<pre>#{File.read($1.strip)}</pre>"
end
File.open(output_file,'w') {|f| f.write RedCloth.new(file_contents).to_html}
