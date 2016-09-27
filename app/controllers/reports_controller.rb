class ReportsController < ApplicationController
  def index
    self.daily
    self.monthly
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
    if params[:reports]
        reports = params[:reports]
        @selected_date = Date.new(reports["date(3i)"].to_i, reports["date(2i)"].to_i)
    end
  end
end
