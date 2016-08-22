class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :creator, class_name: 'User',foreign_key: 'creator_id'
  belongs_to :assigned_user, class_name: 'User',foreign_key: 'assigned_user_id'
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
