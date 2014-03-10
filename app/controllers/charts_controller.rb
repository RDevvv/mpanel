class ChartsController < ApplicationController

  def sms_chart
    @sms = SmsSent.all
    #create an array for storing 30 bars
    #each array element should hold the count for sms_sent everyday
    #create a loop to extract the sms_sent count for each day
    @sms = []
    sms_sent = SmsSent.group('Date(created_at)').count
    (30.days.ago.to_date..Date.today).each do |day|
      @sms.push(sms_sent[day.strftime] || 0)
    end
  end

  def chart_index

  end

  def call_chart
    @call_button_click = ButtonClick.where(:button_class => "call")
    @call_button_click = []
    call = ButtonClick.where(:button_class => "call").group('Date(created_at)').count
    (30.days.ago.to_date..Date.today).each do |day|
      @call_button_click.push(call[day.strftime] || 0)
    end
  end

end



