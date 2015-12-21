class GridWithFileUpload < Netzke::Grid::Base
  attribute :image do |c|
    c.field_config = {
      xtype: :fileuploadfield
    }

    c.column_config = {
      getter: lambda {|r| %Q(<a href='#{r.image.url}'>Download</a>) if r.image.url}
    }
  end

  def configure(c)
    super

    c.model = "Clerk"
    c.persistence = true
    c.columns = [
      :first_name, :last_name, :image
    ]
  end

  include PgGridTweaks
end
