class Application < Netzke::Basepack::Viewport

  action :about do |c|
    c.icon = :information
  end

  js_configure do |c|
    c.layout = :fit
    c.mixin
  end

  def configure(c)
    super

    c.items = [
      { layout: :border,
        docked_items: [
          { dock: :top, xtype: :toolbar, items: [header_html, '->', :about] },
        ],

        items: [
          { region: :west, item_id: :navigation, width: 300, split: true, xtype: :treepanel, root: menu, root_visible: false, title: "Navigation" },
          { region: :center, layout: :border, border: false, items: [
            { item_id: :info_panel, region: :north, height: 40, body_padding: 5, split: true, html: initial_html },
            { item_id: :main_panel, region: :center, layout: :fit, border: false, items: [{}] } # items is only needed here for cosmetic reasons (initial border)
          ]}
        ]
      }
    ]
  end

  def js_configure(c)
    super
    c.intro_html = "Click on a demo component in the navigation tree"
  end

  #
  # Components
  #

  component :bosses do |c|
    c.desc = "A grid configured with just a model. " + source_code_link(c)
  end

  component :clerks do |c|
    c.title = "Clerks"
    c.desc = "A grid with customized columns. " + source_code_link(c)
  end

  component :custom_action_grid do |c|
    c.model  = "Boss"
    c.title  = "Bosses"
    c.desc = "A grid from #{link('this', '/')} tutorial. " + source_code_link(c)
  end

  component :bosses_and_clerks do |c|
    c.title  = "Bosses and Clerks"
    c.desc = "A compound component from #{link("this", "https://github.com/nomadcoder/netzke/wiki/Building-a-composite-component")} tutorial. The component is a sample implementation of the one-to-many relationship UI. " + source_code_link(c)
  end

  component :clerk_paging_form do |c|
    c.title  = "Clerk Paging Form"
    c.desc = "A paging form panel configured with just a model. Browse through the records by clicking on the paging toobar. " + source_code_link(c)
  end

  component :clerk_paging_lockable_form do |c|
    c.title  = "Clerk Paging Lockable Form"
    c.desc = "A paging form panel that is configured to be lockable. " + source_code_link(c)
  end

  component :clerk_form_custom_layout do |c|
    c.klass  = ClerkForm
    c.desc = "A paging form panel with custom layout. " + source_code_link(c)
  end

  component :clerk_inspector do |c|
    c.border  = false
    c.title  = "Simple Clerk Inspector"
  end

protected

  def link(text, uri)
    "<a href='#{uri}'>#{text}</a>"
  end

  def source_code_link(c)
    uri = [NetzkeDemo::Application.config.repo_root, "app/components", c.klass.name.underscore + '.rb'].join('/')
    "<a href='#{uri}' target='_blank'>Source code</a>"
  end

  def header_html
    %Q{
      <div style="color:#333; font-family: Helvetica; font-size: 150%;">
        <a style="color:#B32D15;" href="http://netzke.org">Netzke</a> demo app v0.8
      </div>
    }
  end

  def initial_html
    %Q{
      <div style="color:#333; font-family: Helvetica;">
        <img src='#{uri_to_icon(:information)}'/>
      </div>
    }
  end

  def menu
    {
      :text => "Navigation",
      :expanded => true,
      :children => [{

        :text => "Simple Components",
        :expanded => true,
        :children => [{

          :text => "GridPanel",
          :expanded => true,
          :children => [{
            :text => "Bosses",
            :icon => uri_to_icon(:user_suit),
            :leaf => true,
            :component => "bosses"
          },{
            :text => "Clerks",
            :icon => uri_to_icon(:user),
            :leaf => true,
            :component => "clerks"
          }]
        },{

          :text => "FormPanel",
          :expanded => true,
          :children => [{
            :text => "Paging Form",
            :icon => uri_to_icon(:user),
            :leaf => true,
            :component => "clerk_paging_form"
          },{
            :text => "Paging Form, custom layout",
            :icon => uri_to_icon(:user),
            :leaf => true,
            :component => "clerk_form_custom_layout"
          },{
            :text => "Paging Lockable Form",
            :icon => uri_to_icon(:user),
            :leaf => true,
            :component => "clerk_paging_lockable_form"
          }]
        }]
      },{

        :text => "Composite Components",
        :expanded => true,
        :children => [{
          :text => "Bosses And Clerks",
          :icon => uri_to_icon(:user_user_suit),
          :leaf => true,
          :component => "bosses_and_clerks",
        }]
      }]
    }
  end
end
