require "rails_helper"

RSpec.describe "ProfileService", type: :service do
  let(:profile) { create(:profile) }
  let(:profile_2) { create(:profile, :profile_2) }
  let(:call) { ProfileService.new(params: params) }

  describe "Call find_profile" do
    context "with a valid id" do
      let(:params) { {id: profile.id} }

      it "return profile" do
        response = call.find_profile
        expect(response).to eq(profile)
      end
    end

    context "with an invalid id" do
      let(:params) { {id: 50} }

      it "return nil" do
        response = call.find_profile
        expect(response.id).to eq(50)
        expect(response.name).to be_nil
      end
    end

    context "without an id" do
      let(:params) { {id: nil} }

      it "return nil" do
        response = call.find_profile
        expect(response.id).to be_nil
        expect(response.name).to be_nil
      end
    end
  end

  describe "Call search" do
    context "with a valid name" do
      let(:params) { {search: profile.name} }

      it "return an array of profiles" do
        response = call.search
        expect(response).to eq([profile])
      end
    end

    context "with a valid url" do
      let(:params) { {search: profile.url} }

      it "return an array of profiles" do
        response = call.search
        expect(response).to eq([profile])
      end
    end

    context "with a valid username" do
      let(:params) { {search: profile.username} }

      it "return an array of profiles" do
        response = call.search
        expect(response).to eq([profile])
      end
    end

    context "with a valid organization" do
      let(:params) { {search: profile.organization} }

      it "return an array of profiles" do
        response = call.search
        expect(response).to eq([profile])
      end
    end

    context "with a valid location" do
      let(:params) { {search: profile.location} }

      it "return an array of profiles" do
        response = call.search
        expect(response).to eq([profile])
      end
    end

    context "with an invalid params" do
      let(:params) { {search: Faker::Name.name} }

      it "return an empty array" do
        response = call.search
        expect(response).to eq([])
      end
    end

    context "without params" do
      let(:params) { {search: nil} }

      it "return an array of profiles" do
        response = call.search
        expect(response).to eq([profile])
      end
    end
  end

  describe "Call create_or_update" do
    context "with a valid params for create" do
      let(:params) { {name: "Matz 2", url: "https://github.com/matz"} }

      it "return true" do
        response = call.create_or_update
        expect(response).to be true
        expect(Profile.first.name).to eq(params[:name])
      end
    end

    context "with a duplicate name for create" do
      let(:params) { {name: profile.name, url: "https://github.com/matz"} }

      it "return false" do
        response = call.create_or_update

        expect(response).to be false
        expect(Profile.count).to eq(1)
      end
    end

    context "with an invalid params for create" do
      let(:params) { {name: "Matz 2", url: Faker::Internet.url} }

      it "return nil" do
        response = call.create_or_update

        expect(response).to be_nil
        expect(Profile.first).to be_nil
      end
    end

    context "without params for create" do
      let(:params) { {} }

      it "return nil" do
        response = call.create_or_update

        expect(response).to be_nil
        expect(Profile.first).to be_nil
      end
    end

    context "with a valid params for update" do
      let(:params) { {id: profile.id, name: "Matz 2", url: "https://github.com/matz"} }

      it "return true" do
        response = call.create_or_update

        expect(response).to be true
        expect(Profile.first.id).to eq(profile.id)
        expect(Profile.first.name).to eq(params[:name])
      end
    end

    context "with a duplicate name for update" do
      let(:params) { {id: profile.id, name: profile_2.name, url: "https://github.com/matz"} }

      it "return false" do
        response = call.create_or_update
        profile_base = Profile.find(profile.id)

        expect(response).to be false
        expect(Profile.count).to eq(2)
        expect(profile_base.name).to eq(profile.name)
      end
    end

    context "with an invalid params for update" do
      let(:params) { {id: profile.id, name: "Matz 2", url: Faker::Internet.url} }

      it "return nil" do
        response = call.create_or_update

        expect(response).to be_nil
        expect(Profile.first.name).to eq(profile.name)
      end
    end

    context "without params for update" do
      let(:params) { {id: profile.id} }

      it "return nil" do
        response = call.create_or_update

        expect(response).to be_nil
        expect(Profile.first.name).to eq(profile.name)
      end
    end
  end

  describe "Call destroy" do
    context "with a valid id" do
      let(:params) { {id: profile.id} }

      it "return deleted profile" do
        response = call.destroy

        expect(response).to eq(profile)
        expect(Profile.first).to be_nil
      end
    end

    context "with an invalid id" do
      let(:params) { {id: 50} }

      it "return deleted profile" do
        response = call.destroy

        expect(response.id).to eq(50)
        expect(Profile.first).to be_nil
      end
    end

    context "without an id" do
      let(:params) { {id: nil} }

      it "return deleted profile" do
        response = call.destroy

        expect(response.id).to be_nil
        expect(Profile.first).to be_nil
      end
    end
  end

  describe "Call rescan" do
    context "with a valid id" do
      let(:params) { {id: profile.id} }

      it "return true" do
        response = call.rescan
        expect(response).to be true
      end
    end

    context "with an invalid id" do
      let(:params) { {id: 50} }

      it "return nil" do
        response = call.rescan
        expect(response).to be_nil
      end
    end

    context "without an id" do
      let(:params) { {id: nil} }

      it "return nil" do
        response = call.rescan
        expect(response).to be_nil
      end
    end
  end
end
