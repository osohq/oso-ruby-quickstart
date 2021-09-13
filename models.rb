class Repository
  attr_reader :name, :is_public

  def initialize(name, is_public: false)
    @name  = name
    @is_public = is_public
  end

  def self.get_by_name(name)
    REPOS_DB[name]
  end
end

REPOS_DB = {
  "gmail" => Repository.new("gmail"),
  "react" => Repository.new("react", is_public: true),
  "oso" => Repository.new("oso")
}

class Role
  attr_reader :name, :repository

  def initialize(name, repository)
    @name  = name
    @repository = repository
  end
end

class User
  attr_reader :roles

  def initialize(roles)
    @roles = roles
  end

  def self.get_current_user
    puts USERS_DB
    USERS_DB['larry']
  end
end

USERS_DB = {
  "larry" => User.new([Role.new("admin", REPOS_DB["gmail"])]),
  "anne" => User.new([Role.new("maintainer", REPOS_DB["react"])]),
  "graham" => User.new([Role.new("contributor", REPOS_DB["oso"])]),
}
