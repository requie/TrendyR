class AdminPolicy < HeadlessPolicy
  def access?
    @user.role?(:admin)
  end
end
