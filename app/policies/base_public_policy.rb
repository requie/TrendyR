class BasePublicPolicy < HeadlessPolicy
  def access?
    user.present?
  end
end
