require 'json'

module Traffic
  module Fetchers
    # Fetches traffic status from the Bing Traffic service (http://msdn.microsoft.com/en-us/library/hh441726.aspx)
    # and counts the number of incidents based on different severity.
    class BingTrafficIncidents < Base

      #x = Traffic::Fetchers::BingTraffic.count_incidents '39.202,-76.782,39.461,-76.467', 'KEY GOES HERE'
      #url_config = {/bounding_box/ => bounding_box, /severities/ => severities, /api_key/ => api_key}

      BASE_URL_TEMPLATE = 'http://dev.virtualearth.net/REST/v1/Traffic/Incidents/bounding_box?s=severities&key=api_key'

      # Create a new fetcher and use the given url_config to build the correct URL.
      #
      # @param [Hash] url_config
      #   all keys should be Regexp's which will be used to substitute values in the BASE_URL_TEMPLATE.
      #
      # @option url_config [Regexp] /bounding_box/  an area to get traffic for represented as the latitudes and longitudes separated by commas.
      # @option url_config [Regexp] /severities/  a comma separated list of severities used to filter the incidents that are fetched. Valid values
      #   include 1, 2, 3 and 4. For example, "1,2,3,4" or just "4" to get only severe incidents.
      # @option url_config [Regexp] /api_key/ your Bing Services API key (http://msdn.microsoft.com/en-us/library/ff428642.aspx)
      #
      def initialize(url_config)
        super()
        @url_config = url_config
      end

      # Fetch the incidents afterwards check the results by getting the 'data' from the fetcher.
      def fetch
        http_request(url) do |body|
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

      def url
        @url ||= build_url
      end

      def build_url
        # use the url_config to substitute values in the url_template to build
        # a url
        @url_config.inject(BASE_URL_TEMPLATE) do |url, key_val|
          url.sub key_val.first, key_val.last
        end
      end

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

