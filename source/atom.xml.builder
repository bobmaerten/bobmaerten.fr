xml.instruct!
xml.feed "xmlns" => "http://www.w3.org/2005/Atom" do
  xml.title "Bob Maerten"
  xml.subtitle "Humeurs, interrogations, pâtisseries, développement web, systèmes Linux et autres curiosités"
  xml.id "http://bobmaerten.github.io/"
  xml.link "href" => "http://bobmaerten.github.io/"
  xml.link "href" => "http://bobmaerten.github.io/atom.xml", "rel" => "self"
  xml.updated blog.articles.first.date.to_time.iso8601
  xml.author { xml.name "Bob Maerten" }

  blog.articles[0..5].each do |article|
    xml.entry do
      xml.title article.title
      xml.link "rel" => "alternate", "href" => article.url
      xml.id article.url
      xml.published article.date.to_time.iso8601
      xml.updated article.date.to_time.iso8601
      xml.author { xml.name "Bob Maerten" }
      # xml.summary article.summary, "type" => "html"
      xml.content article.body, "type" => "html"
    end
  end
end
