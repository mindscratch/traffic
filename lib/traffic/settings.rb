module Traffic
  class Settings
    attr_accessor :url_template, :url_config

    def initialize(url_template, url_config={})
      @url_template = url_template
      @url_config = url_config || {}
    end

    def url
      return url_template if url_config.nil? || url_config.empty?
      # use the url_config to substitute values in the url_template to build
      # a url
      url_config.inject(url_template) do |url, key_val|
        url.sub key_val.first, key_val.last
      end
    end

  end
end