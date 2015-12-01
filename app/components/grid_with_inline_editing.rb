class GridWithInlineEditing < Bosses
  def configure(c)
    super
    c.edit_inline = true
  end
end
