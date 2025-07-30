class ProfileService
  attr_reader :params

  def initialize(params: {})
    @params = params
  end

  def find_profile
    @find_profile ||= Profile.find_or_initialize_by(id: params[:id])
  end

  def search
    return Profile.all.order(created_at: :desc) unless params[:search].present?
    Profile.tag_like(params[:search]).order(created_at: :desc)
  end

  def create_or_update
    return unless validate_params && webscrapper_service

    find_profile.name                 = params[:name]
    find_profile.url                  = url_shortener_service
    build_profile_data
  end

  def destroy
    find_profile.destroy
  end

  def rescan
    return unless find_profile.url.present?
    params[:url] = find_profile.url
    build_profile_data
  end

  private

  def build_profile_data
    find_profile.username             = webscrapper_service[:username]
    find_profile.followers_count      = webscrapper_service[:followers_count]
    find_profile.following_count      = webscrapper_service[:following_count]
    find_profile.stars_count          = webscrapper_service[:stars_count]
    find_profile.contributions_count  = webscrapper_service[:contributions_count]
    find_profile.image_url            = webscrapper_service[:image_url]
    find_profile.organization         = webscrapper_service[:organization]
    find_profile.location             = webscrapper_service[:location]

    find_profile.save
  end

  def validate_params
    params[:name].present? && params[:url].present?
  end

  def webscrapper_service
    @webscrapper_service ||= WebscrapperService.new(url: params[:url]).call
  end

  def url_shortener_service
    @url_shortener_service ||= UrlShortenerService.new(url: params[:url]).call
  end
end
