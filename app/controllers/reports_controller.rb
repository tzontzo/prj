class ReportsController < ApplicationController
  def index
    @tasks = Task.all
    @tasks.each do |t|
      intervals = JSON.parse(t.interval)
      seconds_worked = 0
      intervals.each do |i|
        started_at_seconds = Time.parse(i["started_at"]).to_i
        ended_at_seconds = Time.parse(i["ended_at"]).to_i
        seconds_worked += ended_at_seconds - started_at_seconds
      end
      t.time_worked= seconds_worked

    end
  end

end
