class ClerkForm < Netzke::Basepack::PagingFormPanel
  title "Clerk Paging Form With Custom Layout And File Upload"

  model "Clerk"

  add_source_code_tool

  def configure
    super

    boss_contact = [
      {:field_label => "First name", :name => :boss__first_name, :read_only => true},
      {:field_label => "Last name", :name => :boss__last_name, :read_only => true},
      {:field_label => "Email", :name => :boss__email, :read_only => true}
    ]

    boss_details = [
      {:field_label => "Salary", :name => :boss__salary, :read_only => true},
      {:field_label => "Amount of clerks", :name => :boss__clerks_number, :read_only => true}
    ]

    config.file_upload = true
    config.items = [
      {
        :layout => :hbox, :border => false,
        :items => [
          {:flex => 1, :border => false, :defaults => {:anchor => "-8"}, :items => [
            :first_name,
            :email,
            {:name => :image_link, :xtype => :displayfield, :display_only => true, :getter => lambda {|r| %Q(<a href='#{r.image.url}'>Download</a>) if r.image.url}},
            {:name => :image, :field_label => "Upload image", :xtype => :fileuploadfield, :getter => lambda {|r| ""}, :display_only => true}
          ]},
          {:flex => 1, :border => false, :defaults => {:anchor => "100%"}, :items => [
            :last_name,
            :salary,
            :boss__name
          ]}
        ]
      },
      {
        :xtype => :fieldset, :title => "Boss info",
        :items => [
          {
            :xtype => :tabpanel, :body_padding => 5, :plain => true, :active_tab => 0,
            :items => [
              {:title => "Contact", :items => boss_contact},
              {:title => "Details", :items => boss_details}
            ]
          }
        ]
      }
    ]
  end

  def netzke_submit_endpoint(params)
    # ::Rails.logger.debug "!!! params: #{params.inspect}\n"
    super
  end
end
