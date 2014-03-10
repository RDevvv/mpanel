class ChartsController < ApplicationController

  def sms_chart
    @sms = []
    sms_sent = SmsSent.group('Date(created_at)').count
    (30.days.ago.to_date..Date.today).each do |day|
      @sms.push(sms_sent[day.strftime] || 0)
    end
  end

  def chart_index

  end

  def button_click_chart
    @button_click = []
    button_click = ButtonClick.where(:button_class => "#{params[:chart_type]}").group('Date(created_at)').count
    (Date.new(params[:date][:year].to_i, params[:date][:month].to_i)..Date.new(params[:date][:year].to_i, params[:date][:month].to_i, -1)).each do |day|
      @button_click.push(button_click[day.strftime] || 0)
    end
  end

end



