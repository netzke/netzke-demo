class GridWithSummary < Bosses
  column :name do |c|
    c.summary_type = :count
    c.summary_renderer = f(:title_summary_renderer)
  end

  column :salary do |c|
    c.summary_type = :average
    c.summary_renderer = f(:salary_summary_renderer)
  end

  def configure(c)
    super
    c.infinite_scrolling = false
    c.features = [{ ftype: 'summary', dock: :bottom }]
  end
end
