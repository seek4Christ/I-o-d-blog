xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Ola Dan's Blog"
    xml.description "This is a blog about software ,the Bible and many more "
    xml.link root_url
    xml.language "en", "fr", "zh"

    @articles.each do |article|
      xml.item do
        xml.title article.title
        xml.description article.text
        xml.pubDate article.created_at.to_s(:rfc822)
        xml.link article_url(article)
        xml.guid article_url(article)
        text = article.text

       if article.image.exists?
           image_url = article.image.url(:large)
           image_caption = article.image_caption
           image_align = ""
           image_tag = "
               <p><img src='" + image_url +  "' alt='" + image_caption +
               "' title='" + image_caption + "' align='" + image_align
                 + "' /></p>
             "
           text = text.sub('{image}', image_tag)
       end
       xml.description "<p>" + text + "</p>"


      end
    end
  end
end
