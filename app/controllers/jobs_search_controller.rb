class JobsSearchController < ApplicationController
  def search
    request.xhr? ? JobsSearchJob.perform_later(search_params) : set_channel_id
  end

  private

  def search_params
    params.permit(:query, :channel_id)
  end

  # for channel identification purpose
  def set_channel_id
    @channel_id = SecureRandom.alphanumeric(8)
  end
end
