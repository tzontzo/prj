class User < ActiveRecord::Base
  has_many :project_users
  has_many :projects, through: :project_users
  has_many :comments
  def assigned_in?(project)
    self.projects.include?(project)
  end
  def not_assigned_projects
    Project.all - self.projects
  end
  has_secure_password
end
