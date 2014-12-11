puts 'Growing seeds:'

# Create user by role
def create_user_by_role(role_name)
  email = "dev-#{role_name}@example.com"
  return if User.find_by_email(email)
  user = User.new(
    email: email,
    first_name: 'Dev',
    last_name: role_name.capitalize,
    password: "dev-#{role_name}"
  )
  user.roles << Role.instance(role_name)
  user.skip_confirmation!
  user.save!

  user.after_confirmation if Role.public?(role_name)

  puts "- #{role_name} user"
end

# Create users for all roles
Role::ALL.each do |role_name|
  Role.find_or_create_by(name: role_name, is_public: Role.public?(role_name))
  create_user_by_role(role_name)
end

puts 'Done.'
