class BasePrivatePolicy < HeadlessPolicy
  def access?
    @user.role.is_public?
  end
end
