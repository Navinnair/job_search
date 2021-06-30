# frozen_string_literal: true

class StackoverflowJobsService < ApplicationService
  require 'open-uri'
  require 'rss'

  # target url to fetch job listing
  TARGET_URL = 'https://stackoverflow.com/jobs/feed?'

  # location hardcoded to munich
  LOCATION = 'Munich%2C+Deutschland'

  def initialize(query)
    @query = query
  end

  # Service entry point
  def call
    search_and_fetch_jobs
  rescue Exception => e
    raise e.message
  end

  private

  attr_reader :query

  # fetch jobs using the target url and parse
  def search_and_fetch_jobs
    feed = RSS::Parser.parse(open(target_url_with_query))
    feed.items.take(10)
  end

  def target_url_with_query
    "#{TARGET_URL}q=#{query}&l=#{LOCATION}"
  end
end
