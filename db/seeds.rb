Role::ALL.each do |role_name|
  Role.find_or_create_by(name: role_name, is_public: Role::PUBLIC.include?(role_name))
end
