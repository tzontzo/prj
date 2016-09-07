class DashboardController < ApplicationController
	
  def index
    @notes =Note.where("user_id=? or note_type=?",@logged_user["id"], 'company-wide')
  end
end
