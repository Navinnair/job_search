class JobsSearchJob < ApplicationJob
  queue_as :default

  def perform(search_params)
    broadcast_result(search_params)
  end

  private

  def broadcast_result(search_params)
    ActionCable.server.broadcast "job_listing_channel_#{search_params[:channel_id]}",
                                 item: render(search_params[:query])
  end

  def job_list(query)
    StackoverflowJobsService.call(query)
  end

  # if the cache present server from cache otherwise
  # fetch the data using api service
  def render(query)
    Rails.cache.fetch(query, expires_in: 5.minutes) do
      JobListSerializer.render_as_json(job_list(query))
    end
  end
end
