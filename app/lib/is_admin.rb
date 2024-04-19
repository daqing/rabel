class IsAdmin
  def self.call(user)
    user.role == "root" || user.role == "admin"
  end
end
