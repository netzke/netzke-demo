class ClerkPagingLockableForm < Netzke::Basepack::PagingFormPanel
  def configure(c)
    super
    c.mode = :lockable
    c.model = "Clerk"
  end
end
