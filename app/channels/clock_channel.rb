class ClockChannel < ApplicationCable::Channel
  def subscribed
    stream_from "clock_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
