class JobListingChannel < ApplicationCable::Channel
  def subscribed
    stream_from "job_listing_channel_#{params[:channel_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
