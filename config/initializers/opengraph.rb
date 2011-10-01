
module OpenGraph
  def self.fetch(uri)
    #RestClient.head('http://example.com').headers
    page = OpenGraph::Object.new
    page['uri'] = uri
    parsed_page = parse(RestClient.get(uri).body, page)
    parsed_page
  rescue RestClient::Exception, SocketError
    page
  end
  
  def self.parse(html, page)

    doc = Nokogiri::HTML.parse(html)
    doc.css('meta').each do |m|
      if m.attribute('property') && m.attribute('property').to_s.match(/^og:(.+)$/i)
        page[$1.gsub('-','_')] = m.attribute('content').to_s.strip.chomp unless m.attribute('content').to_s.strip.empty?
      end
    end

    doc.css('html>head>meta').each do |m|
      if m.attribute('name') && m.attribute('name').to_s.match(/^(title|description)$/i)
        page[$1.downcase()] = m.attribute('content').to_s.strip.chomp unless m.attribute('content').to_s.strip.empty?
      end
    end

    node = doc.css("html>head>title").first
    page['title'] = node.content.to_s.strip.chomp unless page['title'] || !node

    images = []
    doc.css('img').each do |m|
      if m.attribute('src')
        image = m.attribute('src').to_s.strip.sub(/^\//, '')
        image.insert(0, page['uri'].sub(/\/$/, '') + '/')  unless image.starts_with?('http')
        images << image
      end
    end

    page['images'] = images
    page['image'] = images[0] unless page['image'] || images.empty?

    page['description'] = 'Agrega una descripci&oacute;n...' unless page['description']
    page['type'] = 'webpage' unless page['type']
    page['url'] = page['uri'] unless page['url']

    page
  end
  
end
