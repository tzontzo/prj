class Project < ActiveRecord::Base
  has_many :project_users
  has_many :users, through: :project_users
  has_many :tasks
  def assigned_to?(user)
    self.users.include?(user)
  end
  def not_assigned_users
    User.all - self.users

  end
end
