class ProfilesController < ApplicationController
  protect_from_forgery

  before_action :validate_profile, only: [ :show, :edit, :update, :destroy, :rescan ]

  def index
    @profiles = profile_service.search
  end

  def show
  end

  def new
  end

  def create
    if profile_service.create_or_update
      flash.notice = "Perfil salvo com sucesso"
      redirect_to root_path
    else
      flash.alert = "Houve um problema com o seu processo"
      redirect_back(fallback_location: "/profiles/new")
    end
  end

  def edit
  end

  def update
    if profile_service.create_or_update
      flash.notice = "Perfil atualizado com sucesso"
      redirect_to root_path
    else
      flash.alert = "Houve um problema com o seu processo"
      redirect_back(fallback_location: "/profiles/#{profile_params[:id]}/edit")
    end
  end

  def destroy
    if profile_service.destroy
      flash.notice = "Perfil deletado com sucesso"
    else
      flash.alert = "Houve um problema com o seu processo"
    end

    redirect_to root_path
  end

  def rescan
    if profile_service.rescan
      flash.notice = "Perfil atualizado com sucesso"
    else
      flash.alert = "Houve um problema com o seu processo"
    end

    redirect_back(fallback_location: "/profiles/#{profile_params[:id]}")
  end

  private

  def validate_profile
    @profile = profile_service.find_profile

    unless @profile.username.present?
      flash.alert = "Houve um problema com o seu processo"
      redirect_to root_path
    end
  end

  def profile_service
    @profile_service ||= ProfileService.new(params: profile_params)
  end

  def profile_params
    params.permit(:id, :search, :name, :url)
  end
end
