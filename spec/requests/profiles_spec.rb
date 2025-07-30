require "rails_helper"

RSpec.describe "Profiles", type: :request do
  let(:profile) { create(:profile) }
  let(:params) { {name: "Matz 2", url: "https://github.com/matz"} }
  let(:invalid_params) { {name: "Matz 2", url: Faker::Internet.url} }

  describe "GET /index" do
    it "renders the index template" do
      profile
      get "/"

      expect(assigns(:profiles)).to eq([profile])
      expect(response).to render_template(:index)
    end

    it "when searching by name" do
      get "/?search=#{profile.name}"
      expect(assigns(:profiles)).to eq([profile])
    end

    it "when searching by url" do
      get "/?search=#{profile.url}"
      expect(assigns(:profiles)).to eq([profile])
    end

    it "when searching by username" do
      get "/?search=#{profile.username}"
      expect(assigns(:profiles)).to eq([profile])
    end

    it "when searching by organization" do
      get "/?search=#{profile.organization}"
      expect(assigns(:profiles)).to eq([profile])
    end

    it "when searching by location" do
      get "/?search=#{profile.location}"
      expect(assigns(:profiles)).to eq([profile])
    end

    it "when searching with invalid parameters" do
      profile
      get "/?search=#{Faker::Name.name}"

      expect(assigns(:profiles)).to eq([])
    end
  end

  describe "GET /show" do
    it "renders the show template" do
      get "/profiles/#{profile.id}"
      expect(response).to render_template(:show)
    end

    it "when there is no record" do
      get "/profiles/50"
      expect(response).to redirect_to("/")
    end
  end

  describe "GET /new" do
    it "renders the new template" do
      get "/profiles/new"
      expect(response).to render_template(:new)
    end
  end

  describe "POST /create" do
    it "should create profile and redirect to root" do
      post "/profiles", :params => params

      expect(Profile.first.name).to eq(params[:name])
      expect(response).to redirect_to("/")
    end

    it "when the parameters are invalid" do
      post "/profiles", :params => invalid_params

      expect(Profile.first).to be_nil
      expect(response).to redirect_to("/profiles/new")
    end
  end

  describe "GET /edit" do
    it "renders the edit template" do
      get "/profiles/#{profile.id}/edit"
      expect(response).to render_template(:edit)
    end

    it "when there is no record" do
      get "/profiles/50/edit"
      expect(response).to redirect_to("/")
    end
  end

  describe "PUT /update" do
    it "should update profile and redirect to root" do
      put "/profiles/#{profile.id}", :params => params

      expect(Profile.first.name).to eq(params[:name])
      expect(response).to redirect_to("/")
    end

    it "when the parameters are invalid" do
      put "/profiles/#{profile.id}", :params => invalid_params

      expect(Profile.first.name).to eq(profile.name)
      expect(response).to redirect_to("/profiles/#{profile.id}/edit")
    end

    it "when there is no record" do
      put "/profiles/50", :params => params
      expect(response).to redirect_to("/")
    end
  end

  describe "DELETE /destroy" do
    it "should delete profile and redirect to root" do
      delete "/profiles/#{profile.id}"

      expect(Profile.first).to be_nil
      expect(response).to redirect_to("/")
    end

    it "when there is no record" do
      delete "/profiles/50"
      expect(response).to redirect_to("/")
    end
  end

  describe "PATCH /rescan" do
    it "redirect to show" do
      patch "/profiles/#{profile.id}/rescan"
      expect(response).to redirect_to("/profiles/#{profile.id}")
    end

    it "when there is no record" do
      patch "/profiles/50/rescan"
      expect(response).to redirect_to("/")
    end
  end
end
