require 'spec_helper'
require 'traffic'

describe Traffic::Fetchers::BingTrafficIncidents do

  it "must work" do
    "Yea!".should be_kind_of String
  end

  describe "GET incidents" do
    let(:fetcher) {
      fetcher = Traffic::Fetchers::BingTrafficIncidents.new(
        /bounding_box/ => '39.202,-76.782,39.461,-76.467',
        /api_key/ => 'not-a-real-key',  # VCR was used to fetch the data and the key was filtered out, now the key isn't required b/c the test will use the recorded response
        /severities/ => '1,2,3,4'
      )
    }

    before do
      VCR.insert_cassette 'traffic', :record => :new_episodes
    end

    after do
      VCR.eject_cassette
    end

    it "records the fixture" do
      fetcher.fetch
    end

    it "was successful" do
      fetcher.fetch
      fetcher.message.match(/succeeded/).should_not be_nil
    end

    it "has data" do
      fetcher.fetch
      fetcher.data.should_not be_empty
    end

  end

end