class JobsSearchController < ApplicationController
  before_action :set_channel_id

  def search
    JobsSearchJob.perform_later(search_params)
  end

  private

  def search_params
    params.permit(:query, :channel_id)
  end

  # for channel identification purpose
  def set_channel_id
    @channel_id = rand(36**8).to_s
    params.merge!(:channel_id => @channel_id)
  end

end
