# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def coderay( lang = :ruby, &block )
    require 'coderay'

    text = capture(&block)
    return if text.empty?

    out = ::CodeRay.scan(text, lang).div(:css => :class)

    concat(out, block.binding)
    return
  end
  
  def title(page_title, show_title = true)
    @content_for_title = page_title.to_s
    @show_title = show_title
  end
  
end
