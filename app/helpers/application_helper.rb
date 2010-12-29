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

  def link_to_code(args={})
    file = caller.first.split(":").first
    args[:style] ||= "float:right; border: 1px solid lightgrey; padding: 5px; margin-left: 10px;"
    link_to("Code for this view", [NetzkeDemo::Application.config.repo_root, file.sub(Rails.root.to_s, "")].join, args)
  end

  def new_window_link_to(*args)
    link_to(args[0], args[1] || {}, (args[2] || {}).merge(:target => "_blank"))
  end
end
