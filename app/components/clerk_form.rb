class ClerkForm < Netzke::Basepack::PagingFormPanel

  def default_config
    super.merge(:model => "Clerk")
  end

  def configuration
    boss_basic_info = [
      {:field_label => "First name", :name => :boss__first_name, :read_only => true},
      {:field_label => "Last name", :name => :boss__last_name, :read_only => true},
      {:field_label => "Email", :name => :boss__email, :read_only => true}
    ]

    boss_extra_info = [
      {:field_label => "Salary", :name => :boss__salary, :read_only => true},
      {:field_label => "Amount of clerks", :name => :boss__clerks_number, :read_only => true}
    ]

    super.tap do |s|
      s[:items] = [
        {:layout => :hbox, :border => false, :items => [
          {:flex => 1, :layout => :form, :border => false, :defaults => {:anchor => "-8"}, :items => [:first_name, :email]},
          {:flex => 1, :layout => :form, :border => false, :defaults => {:anchor => "100%"}, :items => [:last_name, :salary]}
        ]},
        {:name => :boss__name},
        {:xtype => :fieldset, :title => "Boss info", :items => [
          {:xtype => :tabpanel, :padding => 5, :plain => true, :active_tab => 0, :items => [{:title => "Basic info", :layout => :form, :label_align => :left, :items => boss_basic_info}, {:title => "Details", :layout => :form, :items => boss_extra_info}]}
        ]}
      ]
    end
  end
end