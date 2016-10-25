class ReportsController < ApplicationController
  def index

    redirect_to action: :daily
  end
  def show
    respond_to do |format|
      format.html
      format.pdf do
        render  pdf: "monthlypdf", template: "reports/monthly"
      end
    end
  end
  def daily
    if params['date'].nil?
      selected_day_start = Time.current.at_beginning_of_day
    else
      selected_day_start = Time.parse(params['date'])
    end

    @selected_day = selected_day_start
    selected_day_end = selected_day_start + 24.hours
    @tasks = get_tasks(selected_day_start,selected_day_end,nil)
    @tasks.each do |t|
      intervals = JSON.parse(t.interval)
      seconds_worked = 0
      intervals.each do |i|
        started_at_seconds = Time.parse(i["started_at"]).to_i
        ended_at_seconds = Time.parse(i["ended_at"]).to_i
        if started_at_seconds > selected_day_start.to_i && started_at_seconds < selected_day_end.to_i
          seconds_worked += ended_at_seconds - started_at_seconds
        end
      end
      t.time_worked= seconds_worked
    end
  end
  def monthly
    @users = User.where('role !=?',"admin")
    if params[:u_id] && params[:u_id].length > 0
      @user_id = User.find(params[:u_id])
    else
      @user_id = nil
    end
    if params[:date]
      @selected_date = "#{params[:date]}-01".to_date
    else
      @selected_date = Date.today.at_beginning_of_month
    end
    @month_start = @selected_date
    @month_end = @selected_date.at_end_of_month
    @tasks = get_tasks(@month_start,@month_end,@user_id)
    @task_intervals = []
    @tasks.each do |t|
      t_intervals = JSON.parse(t.interval)
      @task_intervals << t_intervals.collect { |i|{started_at: Time.parse(i["started_at"]),ended_at: Time.parse(i["ended_at"]),task: t} }
    end
    @task_intervals.flatten!(1)
    @days_month=[]
    (@month_start..@month_end).each do |date|
      current_day_start = date.at_beginning_of_day
      current_day_end = date.at_end_of_day
      current_day_hash = {
          is_free_day:date.instance_eval{saturday?||sunday?},
          tasks: []
      }
      current_day_intervals = @task_intervals.select{|i| i[:started_at] < current_day_end && i[:started_at]> current_day_start}

      current_day_tasks={}
      current_day_intervals.each do |i|
        time_worked = i[:ended_at].to_i - i[:started_at].to_i
        if current_day_tasks.keys.include? i[:task].id
          current_day_tasks[i[:task].id][:time_worked] += time_worked
        else
          current_day_tasks[i[:task].id]= {
              task_obj: i[:task],
              time_worked: time_worked
          }
        end
      end

      current_day_hash[:tasks] = current_day_tasks
      @days_month << current_day_hash
    end
  end
  def get_tasks(started_at,ended_at,user_id)
    tasks=Task.where('(started_at <= ? and ended_at > ? and ended_at <= ?) or
                         (started_at >= ? and ended_at <= ? ) or
                         (started_at >= ? and ended_at >? and started_at < ?) or
                         (started_at <? and ended_at > ?) or (started_at<? and ended_at is NULL ) or(started_at<? and started_at > ?)' ,
                     started_at,started_at,ended_at,
                     started_at,ended_at ,
                     started_at,ended_at ,ended_at ,
                     started_at,ended_at ,started_at,ended_at ,started_at)
    if user_id
      tasks = tasks.where('assigned_user_id =?',user_id)
    end
    tasks
  end
end
