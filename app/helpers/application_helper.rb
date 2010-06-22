module ApplicationHelper
  def title(page_title, show_title = true)
    @content_for_title = page_title.to_s
    @show_title = show_title
  end
  
  def coderay( lang = :ruby, &block )
    # require 'coderay'
    # 
    text = capture(&block)
    # return if text.empty?
    # 
    # out = ::CodeRay.scan(text, lang).div(:css => :class)
    # 
    # concat out
    concat text
    # return
  end
  
end
