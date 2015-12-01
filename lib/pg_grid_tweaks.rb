# As Heroku uses PG, which does not sort records by ids, we need to do it in our grids, so the user experience with inline editing of data is less confusing
module PgGridTweaks
  def configure(c)
    c.store_config = {sorters: {property: :id}}
    super
  end
end
