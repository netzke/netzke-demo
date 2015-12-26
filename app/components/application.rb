class Application < Netzke::Viewport::Base

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
    c.glyph = 'xf0c7@FontAwesome'
  end

  action :sign_in do |c|
    c.glyph = 'xf08b@FontAwesome'
  end

  action :sign_out do |c|
    c.icon = :door_out
    c.text = "Sign out #{current_user.email}" if current_user
  end

  client_class do |c|
    c.layout = :fit
  end

  def configure(c)
    super
    c.intro_html = "Click on a demo component in the navigation tree"
    c.items = [
      { layout: :border,
        tbar: [header_html, '->', :about, current_user ? :sign_out : :sign_in],
        items: [
          { region: :west, item_id: :navigation, width: 300, split: true, xtype: :treepanel, root: menu, root_visible: false, border: false, title: "Navigation" },
          { region: :center, layout: :border, border: false, items: [
            { region: :north, height: 50, border: false, split: true, layout: :fit, items: [{item_id: :info_panel, padding: 5, border: false}] },
            { item_id: :main_panel, region: :center, layout: :fit, border: false, items: [{border: false, body_padding: 5, html: "Components will be loaded in this area"}] } # items is only needed here for cosmetic reasons (initial border)
          ]}
        ]
      }
    ]
  end

  #
  # Components
  #

  component :grid_with_defaults do |c|
    c.desc = "Grid configured with just a model (20K records seeded). Implements infinite scrolling, per-column filtering and sorting, CRUD operations, association support, advanced search etc. " + source_code_link(c)
  end

  component :grid_with_customized_columns do |c|
    c.desc = "Grid with customized columns. " + source_code_link(c)
  end

  component :grid_with_custom_form_layout do |c|
    c.desc = "Grid with customized form layout. " + source_code_link(c)
  end

  component :grid_with_file_upload do |c|
    c.desc = "Grid that handles file attachments. " + source_code_link(c)
  end

  component :grid_with_action_column do |c|
    c.desc = "Grid where you can delet rows by clicking a column action. " + source_code_link(c)
  end

  component :grid_with_persistent_columns do |c|
    c.desc = "Columns size, order, and hidden status will be remembered for this grid across page reloads. " + source_code_link(c)
  end

  component :grid_with_pagination do |c|
    c.desc = "Grid using pagination instead of \"infinite scrolling\" " + source_code_link(c)
  end

  component :grid_with_inline_editing do |c|
    c.desc = "Grid using inline (multi-line) editing of records " + source_code_link(c)
  end

  component :custom_action_grid do |c|
    c.model  = "Boss"
    c.title  = "Bosses"
    c.desc = "Grid from #{link('this', '/')} tutorial. " + source_code_link(c)
  end

  component :files do |c|
    c.desc = "Tree panel configure with just a model. " + source_code_link(c)
  end

  component :grid_with_glyphicons do |c|
    c.desc = "This grid has actions and header configured with glyphicons. " + source_code_link(c)
  end

  component :grid_with_live_search do |c|
    c.desc = "Grid showing off Basepack::GridLiveSearch plugin. " + source_code_link(c)
  end

  #
  # Composite components
  #

  component :bosses_and_clerks do |c|
    c.title  = "Bosses and Clerks"
    c.desc = "A compound component from #{link("this", "https://github.com/netzke/netzke/wiki/Building-a-composite-component")} tutorial. The component is a sample implementation of the one-to-many relationship UI. " + source_code_link(c)
  end

  component :tab_panel_with_grids do |c|
    c.desc = "A TabPanel. " + source_code_link(c)
  end

  component :accordion_with_grids do |c|
    c.desc = "An Accordion. " + source_code_link(c)
  end

  component :simple_window do |c|
    c.desc = "A simple window with persistent dimensions, position, and state. " + source_code_link(c)
  end

  component :window_with_grid do |c|
    c.desc = "A window that nests a Grid. #{source_code_link(c)}"
  end

  component :window_nesting_bosses_and_clerks do |c|
    c.desc = "A window that nests a compound component (see the 'Bosses and Clerks' example). #{source_code_link(c)}"
  end

  component :for_authenticated do |c|
    c.klass = Netzke::Core::Panel
    c.desc = "A simple panel that can only be loaded when the user is authenticated. It's defined inline in components/application.rb, there's no separate class for it."
    c.html = "You cannot load this component even by tweaking the URI, because it's configured with authorization in mind."
    c.body_padding = 5
  end

  # Endpoints
  #
  #
  endpoint :sign_in do |params|
    user = User.new
    if User.authenticate_with?(params[:email], params[:password])
      session[:user_id] = 1 # authenticated user's fake ID; see #current_user below
      true
    else
      this.netzke_feedback("Wrong credentials")
      false
    end
  end

  endpoint :sign_out do |params|
    session[:user_id] = nil
    true
  end

protected

  # Fake implementation, returns user by user_id stored in the session
  def current_user
    @current_user ||= session[:user_id] && User.new
  end

  def link(text, uri)
    "<a href='#{uri}'>#{text}</a>"
  end

  def source_code_link(c)
    comp_file_name = c.klass.nil? ? c.name.underscore : c.klass.name.underscore
    uri = [NetzkeDemo::Application.config.repo_root, "app/components", comp_file_name + '.rb'].join('/')
    "<a href='#{uri}' target='_blank'>Source code</a>"
  end

  def header_html
    %Q{
      <div style="font-size: 150%;">
        <a style="color:#B32D15;" href="http://netzke.org">Netzke</a> demo app (Netzke 1.0.0.0.alpha, Rails 4.2, Ext JS 5.1)
      </div>
    }
  end

  def leaf(text, component, icon = nil)
    { text: text,
      id: component,
      cmp: component,
      leaf: true
    }
  end

  def menu
    out = { :text => "Navigation",
      :expanded => true,
      :children => [

        { :text => "Basic components",
          :expanded => true,
          :children => [

            { :text => "Grid",
              :expanded => true,
              :children => [
                leaf("Basic configuration", :grid_with_defaults, :table),
                leaf("Customized columns", :grid_with_customized_columns, :table),
                leaf("Customized form layout", :"grid_with_custom_form_layout", :table),
                leaf("Action column", :grid_with_action_column, :table),
                leaf("Persistent columns", :grid_with_persistent_columns, :table),
                leaf("Pagination", :grid_with_pagination, :table),
                leaf("Inline editing", :grid_with_inline_editing, :table),
                leaf("File upload", :grid_with_file_upload, :table),
                leaf("Live search", :grid_with_live_search, :table),
                leaf("Glyphicons", :grid_with_glyphicons)
              ]
            },

            { text: "Tree",
              expanded: true,
              children: [
                leaf("Tree panel", :files, :application_side_tree)
              ]
            },

            { text: "Window",
              expanded: true,
              children: [
                leaf("Simple window", :simple_window, :application),
                leaf("Window nesting a grid", :window_with_grid, :application_view_detail),
                leaf("Window nesting a compound component", :window_nesting_bosses_and_clerks, :application_tile_horizontal)
              ]
            }
          ]
        },

        { :text => "Composite components",
          :expanded => true,
          :children => [
            leaf("Bosses and Clerks", :bosses_and_clerks, :user_user_suit),
            leaf("TabPanel", :tab_panel_with_grids, :bullet_black),
            leaf("Accordion", :accordion_with_grids, :bullet_black),
          ]
        }
      ]
    }

    if current_user
      out[:children] << { text: "Private components", expanded: true, children: [ leaf("For authenticated users", :for_authenticated, :lock) ]}
    end

    out
  end
end
