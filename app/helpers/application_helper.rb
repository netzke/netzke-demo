module ApplicationHelper
  def coderay( lang = :ruby, &block )
    require 'coderay'

    text = with_output_buffer(&block)
    
    return if text.empty?

    raw ::CodeRay.scan(text, lang).div(:css => :class)
  end
  
  def title(page_title, show_title = true)
    content_for :title, page_title.to_s
    @show_title = show_title
  end
  
  def show_title?
    @show_title
  end
end
