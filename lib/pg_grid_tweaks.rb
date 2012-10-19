module PgGridTweaks
  def configure(c)
    c.data_store.sorters = {property: :id}
    super
  end
end
