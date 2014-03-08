class StaticPagesController < ApplicationController
  require 'will_paginate/array'
  # WillPaginate.per_page = 20

  include UsersHelper


  def index
    Time.zone = 'Pacific Time (US & Canada)'
    d = Time.now.in_time_zone(Time.zone)
    
    # selecting only events that are today. First getting events that are today. Then we are sorting it by comparing each one?
    @events_today = Event.order(:start_at).select {|x| x.end_at > d && x.end_at <= d.at_end_of_day }
    
    #testing
    #puts @events_today

    @left_name = "Today"

    @user = current_user

    if not @user.blank?
      groups = Set.new(@user.groups.map(&:id))
      @events_today.select! {|e| groups.include? e.group.id }
    end

    # if there are no more events today then start showing events tomorrow
    if @events_today.count == 0
      d = (d + 1.day).at_beginning_of_day
      @events_today = Event.order(:start_at).select {|x| x.end_at > d && x.end_at <= d.at_end_of_day }
        @left_name = "Tomorrow"

      # only select user subscribed groups
      if not @user.blank?
        @events_today.select! {|e| groups.include? e.group.id }
      end

    end

    #@events_today = @events_today.paginate(page: params[:page])
    
    
    @events_upcoming = Event.order(:start_at).select {|x| x.end_at > d.at_end_of_day }
    # @events = Event.paginate(page: params[:page])

    if not @user.blank?
      @events_upcoming.select! {|e| groups.include? e.group.id }
    end

    @events_upcoming = @events_upcoming.paginate(page: params[:page], per_page: 20)
    
  end


  def about
  end

end
