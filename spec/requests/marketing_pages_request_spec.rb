require 'rails_helper'

RSpec.describe "MarketingPages", type: :request do

  describe "GET /homepage" do
    it "returns http success" do
      get "/marketing_pages/homepage"
      expect(response).to have_http_status(:success)
    end
  end

end
