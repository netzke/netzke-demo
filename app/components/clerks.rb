# Extend Grid to be specific about the model and columns we want to display
class Clerks < Netzke::Basepack::Grid
  client_styles do |c|
    # include CSS for displaying the light bulb (see the source code)
    c.require :main
  end

  attribute :image do |c|
    c.getter = lambda {|r| %Q(<a href='#{r.image.url}'>Download</a>) if r.image.url}

    c.field_config = {
      # In the forms, show it as label, not field
      xtype: :displayfield
    }
  end

  attribute :updated_bulb do |c|
    # Do not show this virtual attribute in the form
    c.field_config = { excluded: true }
  end

  def configure(c)
    c.model = "Clerk"
    c.persistence = true

    # Declaring columns
    c.columns = [
      { :name => :name,
        :renderer => "uppercase",
        :width => 200
      },
      :first_name,
      :last_name,
      { :name => :updated_bulb,
        :width => 30,
        :header => "",
        :tooltip => "Recently updated",
        :getter => lambda { |r|
          bulb = r.updated ? "on" : "off"
          "<div class='bulb-#{bulb}' />"
        }
      },
      :email,
      { :name => :boss__last_name,
        :header => "Boss"
      },
      :image
    ]
    super
  end

  include PgGridTweaks
end
