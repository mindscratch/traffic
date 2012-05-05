require 'json'

module Traffic
  module Fetchers
    class BingTraffic < Base

      #x = Traffic::Fetchers::BingTraffic.count_incidents '39.202,-76.782,39.461,-76.467', 'KEY GOES HERE'

      def self.count_incidents(bounding_box, api_key, severities='1,2,3,4')
        url = 'http://dev.virtualearth.net/REST/v1/Traffic/Incidents/bounding_box?s=severities&key=api_key'
        url_config = {/bounding_box/ => bounding_box, /severities/ => severities, /api_key/ => api_key}
        settings = Traffic::Settings.new url, url_config
        fetcher = self.new settings
        fetcher.fetch
        fetcher
      end

      def fetch
        http_request(@settings.url) do |body|
          incidents = JSON.parse body

          counts = {}
          total = incidents["resourceSets"].first["estimatedTotal"]
          resources = incidents["resourceSets"].first["resources"]
          resources.each do |resource|
            severity = resource["severity"]
            counts[severity] = (counts.fetch severity, 0) + 1
          end

          @data = {}
          counts.each do |severity, count|
            @data[severity_label(severity)] = count
          end
        end
      end

      private

      def severity_label(severity)
        case severity
        when 1
          "low impact"
        when 2
          "minor"
        when 3
          "moderate"
        when 4
          "severe"
        else
          "unknown"
        end
      end
    end
  end
end

