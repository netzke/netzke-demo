class GridWithInlineEditing < Bosses
  def configure(c)
    super
    c.editing = :inline
  end
end
