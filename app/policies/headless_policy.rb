# Base class for all headless policies
# https://github.com/elabs/pundit#headless-policies
#
# Take a look at admin_policy.rb or base_policy.rb
#
class HeadlessPolicy < Struct.new(:user, :record)
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end
end
