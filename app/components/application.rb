class Application < Netzke::Basepack::Viewport

  # A simple mockup of the User model
  class User < Struct.new(:email, :password)
    def initialize
      self.email = "demo@netzke.org"
      self.password = "netzke"
    end
    def self.authenticate_with?(email, password)
      instance = self.new
      [email, password] == [instance.email, instance.password]
    end
  end

  action :about do |c|
    c.icon = :information
  end

  action :sign_in do |c|
    c.icon = :door_in
  end

  action :sign_out do |c|
    c.icon = :door_out
    c.text = "Sign out #{current_user.email}" if current_user
  end

  js_configure do |c|
    c.layout = :fit
    c.mixin
  end

  def configure(c)
    super
    c.intro_html = "Click on a demo component in the navigation tree"
    c.items = [
      { layout: :border,
        tbar: [header_html, '->', :about, current_user ? :sign_out : :sign_in],
        items: [
          { region: :west, item_id: :navigation, width: 300, split: true, xtype: :treepanel, root: menu, root_visible: false, title: "Navigation" },
          { region: :center, layout: :border, border: false, items: [
            { item_id: :info_panel, region: :north, height: 35, body_padding: 5, split: true, html: initial_html },
            { item_id: :main_panel, region: :center, layout: :fit, border: false, items: [{}] } # items is only needed here for cosmetic reasons (initial border)
          ]}
        ]
      }
    ]
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

  #
  # Composite components
  #

  component :bosses_and_clerks do |c|
    c.title  = "Bosses and Clerks"
    c.desc = "A compound component from #{link("this", "https://github.com/nomadcoder/netzke/wiki/Building-a-composite-component")} tutorial. The component is a sample implementation of the one-to-many relationship UI. " + source_code_link(c)
  end

  component :static_tab_panel do |c|
    c.desc = "A TabPanel with pre-loaded tabs (as opposed to dynamically loaded components). " + source_code_link(c)
  end

  component :dynamic_tab_panel do |c|
    c.desc = "A TabPanel with dynamically loaded tab components. " + source_code_link(c)
  end

  component :static_accordion do |c|
    c.desc = "An Accordion with pre-loaded tabs (as opposed to dynamically loaded components). " + source_code_link(c)
  end

  component :dynamic_accordion do |c|
    c.desc = "An Accordion with dynamically loaded tab components. " + source_code_link(c)
  end

  component :simple_window do |c|
    c.desc = "A simple window with persistent dimensions, position, and state. " + source_code_link(c)
  end

  component :window_with_grid_panel do |c|
    c.desc = "A window that nests a GridPanel. #{source_code_link(c)}"
  end

  component :window_nesting_bosses_and_clerks do |c|
    c.desc = "A window that nests a compound component (see the 'Bosses and Clerks' example). #{source_code_link(c)}"
  end

  # Endpoints
  #
  #
  endpoint :sign_in do |params,this|
    user = User.new
    if User.authenticate_with?(params[:email], params[:password])
      session[:user_id] = 1 # anything; this is what you'd normally do in a real-life case
      this.set_result(true)
    else
      this.set_result(false)
      this.netzkeFeedback("Wrong credentials")
    end
  end

  endpoint :sign_out do |params,this|
    session[:user_id] = nil
    this.set_result(true)
  end

protected

  def current_user
    @current_user ||= session[:user_id] && User.new
  end

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

  def leaf(text, component, icon = nil)
    { text: text,
      icon: icon && uri_to_icon(icon),
      cmp: component,
      leaf: true
    }
  end

  def menu
    { :text => "Navigation",
      :expanded => true,
      :children => [

        { :text => "Basic components",
          :expanded => true,
          :children => [

            { :text => "GridPanel",
              :expanded => true,
              :children => [
                leaf("Bosses", :bosses, :user_suit),
                leaf("Clerks", :clerks, :user)
              ]
            },

            { :text => "FormPanel",
              :expanded => true,
              :children => [
                leaf("Paging Form", :clerk_paging_form, :user),
                leaf("Paging Form, custom layout", :clerk_form_custom_layout, :user),
                leaf("Paging Lockable Form", :clerk_paging_lockable_form, :user),
              ]
            },

            { text: "Window",
              expanded: true,
              children: [
                leaf("Simple window", :simple_window),
                leaf("Window nesting a grid", :window_with_grid_panel),
                leaf("Window nesting a compound component", :window_nesting_bosses_and_clerks)
              ]
            }
          ]
        },

        { :text => "Composite components",
          :expanded => true,
          :children => [
            leaf("Bosses and Clerks", :bosses_and_clerks, :user_user_suit),
            leaf("TabPanel (static)", :static_tab_panel),
            leaf("TabPanel (dynamic)", :dynamic_tab_panel),
            leaf("Accordion (static)", :static_accordion),
            leaf("Accordion (dynamic)", :dynamic_accordion),
          ]
        }
      ]
    }
  end
end
