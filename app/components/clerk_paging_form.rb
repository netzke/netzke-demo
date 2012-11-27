class ClerkPagingForm < Netzke::Basepack::PagingForm
  def configure(c)
    super
    c.model = "Clerk"
  end
end
