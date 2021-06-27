class JobListSerializer < Blueprinter::Base
  fields :title, :link, :pubDate

  field :content_id do |job, _|
    job.guid.content
  end
end