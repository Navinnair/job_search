require "rails_helper"

RSpec.describe JobListingChannel, type: :channel do

  it "successfully subscribes" do
    stub_connection channel_id: 'test_channel'
    subscribe
    expect(subscription).to be_confirmed
    expect(subscription.channel_id).to eq 'test_channel'
  end

  it "successfully connects" do
    stub_connection channel_id: 'test_channel'
    expect(connection.channel_id).to eq 'test_channel'
  end

end
