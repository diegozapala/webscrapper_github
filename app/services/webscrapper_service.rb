class WebscrapperService
  require "selenium-webdriver"

  attr_reader :url

  BASE_URL_GITHUB = "https://github.com/"
  BASE_SHORT_URL = "https://l1nq.com/"

  def initialize(url:)
    @url = url
  end

  def call
    return unless validate_url

    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument("--headless")
    driver = Selenium::WebDriver.for :chrome, options: options
    driver.navigate.to url

    sleep 3

    return unless validate_field(driver.find_elements(:css, "span.p-nickname.vcard-username"), 0)
    build_data(driver)
  end

  private

  def build_data(resp)
    {
      username:            resp.find_elements(:css, "span.p-nickname.vcard-username")[0].text.strip,
      followers_count:     resp.find_elements(:css, "span.text-bold.color-fg-default")[0].text.strip,
      following_count:     resp.find_elements(:css, "span.text-bold.color-fg-default")[1].text.strip,
      stars_count:         resp.find_elements(:css, "a.UnderlineNav-item span")[3].attribute("title").strip,
      contributions_count: validate_field(resp.find_elements(:css, "#js-contribution-activity-description"), 0).delete("contributions in the last year"),
      image_url:           resp.find_elements(:css, "img.avatar.avatar-user.width-full")[0].attribute("src"),
      organization:        validate_field(resp.find_elements(:css, "li[itemprop='worksFor']"), 0),
      location:            validate_field(resp.find_elements(:css, "li[itemprop='homeLocation']"), 0)
    }
  end

  def validate_url
    url.present? && (uri_parse.is_a?(URI::HTTP) || uri_parse.is_a?(URI::HTTPS)) && vaild_base_url
  end

  def uri_parse
    @uri ||= URI.parse(url)
  end

  def vaild_base_url
    url[0..18] == BASE_URL_GITHUB || url[0..16] == BASE_SHORT_URL
  end

  def validate_field(field, i)
    return unless field[i].present?
    field[i].text.strip
  end
end
