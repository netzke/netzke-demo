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
            { item_id: :main_panel, region: :center, layout: :fit }
          ]}
        ]
      }
    ]
  end

  def js_configure(c)
    super
    c.intro_html = "Click on a demo component in the navigation tree"
  end

  # Components
  component :bosses do |c|
    c.klass = Netzke::Basepack::GridPanel
    c.model = "Boss"
    c.title = "Bosses"
    c.persistence  = true
    c.desc = "Blah blah"
  end

  component :clerks do |c|
    c.klass = Netzke::Basepack::GridPanel
    c.model = "Clerk"
    c.title = "Clerks"
    c.persistence  = true
  end

  component :customized_clerks do |c|
    c.klass = ClerkGrid
    c.title = "Customized Clerks"
    c.desc = "ClerkGrid from tutorial"
  end

  component :custom_action_grid do |c|
    c.model  = "Boss"
    c.title  = "Custom Action Grid"
    c.persistence  = true
  end

  component :bosses_and_clerks do |c|
    c.title  = "Bosses and Clerks"
  end

  component :clerk_paging_form do |c|
    c.title  = "Clerk Paging Form"
    c.model  = "Clerk"
    c.klass  = Netzke::Basepack::PagingFormPanel
  end

  component :clerk_paging_lockable_form do |c|
    c.title  = "Clerk Paging Lockable Form"
    c.model  = "Clerk"
    c.klass = Netzke::Basepack::PagingFormPanel
    c.mode  = :lockable
  end

  component :clerk_form_custom_layout do |c|
    c.klass  = ClerkForm
  end

  component :clerk_inspecto do |c|
    c.border  = false
    c.title  = "Simple Clerk Inspector"
  end

protected

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
            :component => "bosses",
            :desc => "Lorem ipsum"
          },{
            :text => "Clerks",
            :icon => uri_to_icon(:user),
            :leaf => true,
            :component => "clerks"
          },{
            :text => "Customized Clerks",
            :icon => uri_to_icon(:user),
            :leaf => true,
            :component => "customized_clerks"
          },{
            :text => "Custom Action Grid",
            :leaf => true,
            :component => "custom_action_grid"
          }]
        },{
          :text => "FormPanel",
          :expanded => true,
          :children => [{
            :text => "Clerks Paging Form",
            :icon => uri_to_icon(:user),
            :leaf => true,
            :component => "clerk_paging_form"
          },{
            :text => "Clerks Paging Lockable Form",
            :icon => uri_to_icon(:user),
            :leaf => true,
            :component => "clerk_paging_lockable_form"
          },{
            :text => "Clerks Paging Form, custom layout",
            :icon => uri_to_icon(:user),
            :leaf => true,
            :component => "clerk_form_custom_layout"
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
        },{
            :text => "Simple Portal",
            :leaf => true,
            :component => "simple_portal"
          }]
      },{
        :text => "Stand-alone Components",
        :leaf => true,
        :component => "embedded"
      }]
    }
  end
end
