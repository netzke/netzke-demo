class ClerkPagingForm < Netzke::Basepack::PagingFormPanel
  def configure(c)
    super
    c.model = "Clerk"
  end
end
