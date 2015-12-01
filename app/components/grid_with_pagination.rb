class GridWithPagination < Bosses
  def configure(c)
    super
    c.paging = true
  end
end
