require 'nokogiri'
require 'rest-client'
require 'byebug'

domain= "https://www.springfieldspringfield.co.uk/"
# show = "30-rock"
# show = "will-and-grace"
# show = "schitts-creek-2015"
show = "the-simpsons"

page_url = "#{domain}episode_scripts.php?tv-show=#{show}"

output = File.open(show+"2.txt", "w")
page = Nokogiri::HTML(RestClient.get(page_url))
i=1
page.css(".season-episodes a").each do |link|
  puts "Parseing #{i}"
  puts link.attr('href')
  script = Nokogiri::HTML(RestClient.get(domain+link.attr('href')))
  data = script.css(".scrolling-script-container")[0].inner_html.gsub("<br>","\n").gsub(/ -/,"") + "\n\n"
  puts data
  output.write data
  
  i+=1
end
