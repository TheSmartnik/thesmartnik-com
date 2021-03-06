FILES_TO_SKIP = %w(404.html)

pages = sitemap.resources.select do |page|
  page.path =~ /\.html/ && !FILES_TO_SKIP.include?(page.path)
end

xml.instruct!
xml.urlset 'xmlns' => "http://www.sitemaps.org/schemas/sitemap/0.9" do
  pages.each do |page|
    xml.url do
      xml.loc "https://#{config.domain}#{page.url}"
      xml.lastmod File.mtime(page.source_file).utc.iso8601
      xml.changefreq page.data.changefreq || "weekly"
      xml.priority page.data.priority || "1.0"
    end
  end
end
