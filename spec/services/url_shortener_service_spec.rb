require "rails_helper"

RSpec.describe "UrlShortenerService", type: :service do
  let(:call) { UrlShortenerService.new(url: url).call }

  describe "Call service" do
    context "with a new valid url" do
      let(:base_short_url) { "https://l1nq.com/" }
      let(:url) { Faker::Internet.url }

      it "return the shortened url" do
        response = call
        expect(response).to include(base_short_url)
      end
    end

    context "with a valid shortened url" do
      let(:url) { "https://l1nq.com/qwert" }

      it "return the same shortened url" do
        response = call
        expect(response).to eq(url)
      end
    end

    context "with an invalid url" do
      let(:url) { Faker::Alphanumeric.alpha(number: 10) }

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
