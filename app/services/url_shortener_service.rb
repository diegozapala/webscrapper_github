class UrlShortenerService
  require "net/http"

  attr_reader :url

  BASE_URL = "https://api.encurtador.dev/encurtamentos"
  BASE_SHORT_URL = "https://l1nq.com/"

  def initialize(url:)
    @url = url
  end

  def call
    return unless validate_url
    return url if url.include?(BASE_SHORT_URL)

    http = Net::HTTP.new(build_base_uri.host, build_base_uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(build_base_uri)
    request["Content-Type"] = "application/json"
    request.body = build_params

    resp = http.request(request)

    if resp.is_a?(Net::HTTPSuccess)
      build_short_url(parse_to_json(resp.body)["urlEncurtada"])
    else
      url
    end
  end

  private

  def validate_url
    url.present? && (uri_parse.is_a?(URI::HTTP) || uri_parse.is_a?(URI::HTTPS))
  end

  def build_base_uri
    @base_uri ||= URI(BASE_URL)
  end

  def build_params
    @params ||= "{ \"url\": \"#{url}\" }"
  end

  def build_short_url(resp)
    BASE_SHORT_URL+resp.split("/").last
  end

  def uri_parse
    @uri ||= URI.parse(url)
  end

  def parse_to_json(string)
    JSON.parse(string);
  end
end
