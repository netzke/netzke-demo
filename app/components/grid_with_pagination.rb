class GridWithPagination < Bosses
  def configure(c)
    super
    c.paging = :pagination
  end
end
