class GuestPolicy < HeadlessPolicy
  # anyone can access guest routes
  def access?
    true
  end
end
