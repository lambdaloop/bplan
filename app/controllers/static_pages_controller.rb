class StaticPagesController < ApplicationController
    require 'will_paginate/array'
    WillPaginate.per_page = 10

  def index
    Time.zone = 'Pacific Time (US & Canada)'
    #d = Time.new(2014, 03, 1)
    d = Time.now.in_time_zone(Time.zone)
    # d = d.at_beginning_of_day + 2
    
    # selecting only events that are today. First getting events that are today. Then we are sorting it by comparing each one?
    @events_today = Event.order(:start_at).select {|x| x.end_at > d && x.end_at <= d.at_end_of_day }

    @left_name = "Today"

    
    if @events_today.count == 0
      d = (d + 1.day).at_beginning_of_day
      @events_today = Event.order(:start_at).select {|x| x.end_at > d && x.end_at <= d.at_end_of_day }
      @left_name = "Tomorrow"
    end

    #@events_today = @events_today.paginate(page: params[:page])
    
    
    @events_upcoming = Event.order(:start_at).select {|x| x.end_at > d.at_end_of_day }.paginate(page: params[:page])
  # @events = Event.paginate(page: params[:page])
  end

end
