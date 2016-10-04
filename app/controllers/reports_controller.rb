class ReportsController < ApplicationController
  def index
    redirect_to action: :daily
  end
  def daily

    if params['date'].nil?
      selected_day_start = Time.current.at_beginning_of_day
    else
      selected_day_start = Time.parse(params['date'])
    end

    @selected_day = selected_day_start
    selected_day_end = selected_day_start + 24.hours

    @tasks = Task.where('(started_at <= ? and ended_at > ? and ended_at <= ?) or
                         (started_at >= ? and ended_at <= ? ) or
                         (started_at >= ? and ended_at >? and started_at < ?) or
                         (started_at <? and ended_at > ?) or (started_at<? and ended_at is NULL ) or(started_at<? and started_at > ?)' ,
                        selected_day_start,selected_day_start,selected_day_end    ,
                        selected_day_start,selected_day_end,
                        selected_day_start,selected_day_end,selected_day_end,
                        selected_day_start,selected_day_end,selected_day_start,selected_day_end,selected_day_start)
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
    if params[:date]
      selected_date = "#{params[:date]}-01".to_date
    else
      selected_date = Date.today.at_beginning_of_month
    end
    @month_start = selected_date
    @month_end = selected_date.at_end_of_month
    @tasks = Task.where('(started_at >=? and ended_at is NULL and started_at <?) or (started_at >=? and ended_at <=?)',@month_start,@month_end,@month_start,@month_end)
    task_intervals = []
    @tasks.each do |t|
      t_intervals = JSON.parse(t.interval)
      t_intervals.collect { |i|{stated_at: Time.parse(i["started_at"]),ended_at: Time.parse(i["ended_at"]),task: t} }
    end
    @days_month=[]
    (@month_start..@month_end).each do |date|
      current_day_start = date.at_beginning_of_day
      current_day_end = date.at_end_of_day
      current_day_hash = {
          is_free_day:date.instance_eval{saturday?||sunday?},
          tasks: []
      }
      current_day_intervals = task_intervals.select{|i| i[:started_at] < current_day_end && i[:started_at]> current_day_start}
      current_day_tasks={}
      current_day_intervals.each do |i|
        if current_day_tasks.keys.include? i[:task].id
          current_day_tasks[i[:task].id][:time_worked] += time_worked
        else
          current_day_tasks[i[:tasks].id]= {
              task_obj: i[:task],
              time_worked: time_worked
          }
        end
      end
      current_day_hash[:tasks] = current_day_tasks
      @days_month << current_day_hash
    end
  end
end
