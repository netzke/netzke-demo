class ClerkPagingLockableForm < Netzke::Basepack::PagingForm
  def configure(c)
    super
    c.mode = :lockable
    c.model = "Clerk"
  end
end
