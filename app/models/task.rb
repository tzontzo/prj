class Task < ActiveRecord::Base
  belongs_to :project
  has_many :task_users
  has_many :users, through: :task_users
  has_many :comments
  def assigned_to?(user)
    self.users.include?(user)
  end
  def not_assigned_users
    User.all - self.users

  end
end
