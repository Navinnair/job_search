require 'rails_helper'

RSpec.describe StackoverflowJobsService do
  describe '.call' do
    context 'when user search with query' do
      let(:sample_response) do
        "<item>
        <title>DevOps/Sysadmin (m/w/d) Kubernetes at Hetzner Cloud GmbH (Unterföhring, Deutschland)</title>
        <link>https://stackoverflow.com/jobs/224179/devops-sysadmin-m-w-d-kubernetes-hetzner-cloud-gmbh?a=1dbkeECoZ70c&amp;so_medium=Talent&amp;so_source=TalentApi</link>
        <description>Test</description>
        <category>devops</category>
        <category>linux</category>
        <category>kubernetes</category>
        <category>ansible</category>
        <category>sysadmin</category>
        <pubDate>Thu, 10 Jun 2021 09:58:55 -0000</pubDate>
        <guid isPermaLink='false'>224179</guid>
      </item>"
      end

      it 'should return the results' do
        allow_any_instance_of(StackoverflowJobsService).to receive(:search_and_fetch_jobs).and_return(sample_response)
        expect(StackoverflowJobsService.call('devops')).to eq(sample_response)
      end
    end
  end
end
