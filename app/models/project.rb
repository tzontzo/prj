class Project < ActiveRecord::Base
  has_and_belongs_to_many :programmers
  belongs_to :team_leader
end
