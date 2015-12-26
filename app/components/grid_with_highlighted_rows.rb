# To achive this, we needed to extend the client side of the Grid, see the
# `componetns/grid_with_highlighted_rows/client` dir.
class GridWithHighlightedRows < Netzke::Grid::Base
  client_styles do |c|
    c.require :highlighted_row
  end

  def configure(c)
    super
    c.model = Employee
  end
end
