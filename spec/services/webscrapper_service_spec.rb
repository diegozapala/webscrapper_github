require "rails_helper"

RSpec.describe "WebscrapperService", type: :service do
  let(:call) { WebscrapperService.new(url: url).call }

  describe "Call service" do
    context "with a new valid url" do
      let(:url) { "https://github.com/matz" }

      it "return hash of values" do
        response = call
        expect(response).to have_key(:username)
        expect(response).to have_key(:followers_count)
        expect(response).to have_key(:following_count)
        expect(response).to have_key(:stars_count)
        expect(response).to have_key(:contributions_count)
        expect(response).to have_key(:image_url)
        expect(response).to have_key(:organization)
        expect(response).to have_key(:location)
      end
    end

    context "with a valid shortened url" do
      let(:url) { UrlShortenerService.new(url: "https://github.com/matz").call }

      it "return hash of values" do
        response = call
        expect(response).to have_key(:username)
        expect(response).to have_key(:followers_count)
        expect(response).to have_key(:following_count)
        expect(response).to have_key(:stars_count)
        expect(response).to have_key(:contributions_count)
        expect(response).to have_key(:image_url)
        expect(response).to have_key(:organization)
        expect(response).to have_key(:location)
      end
    end

    context "with an invalid url" do
      let(:url) { Faker::Alphanumeric.alpha(number: 10) }

      it "return nil" do
        response = call
        expect(response).to be_nil
      end
    end

    context "with the url has no username" do
      let(:url) { "https://github.com/" }

      it "return nil" do
        response = call
        expect(response).to be_nil
      end
    end

    context "without a url" do
      let(:url) { "" }

      it "return nil" do
        response = call
        expect(response).to be_nil
      end
    end
  end
end
