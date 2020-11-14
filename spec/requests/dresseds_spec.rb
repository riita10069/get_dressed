require 'rails_helper'

RSpec.describe "Dresseds", type: :request do
  describe "GET /dresseds" do
    it "works! (now write some real specs)" do
      get dresseds_path
      expect(response).to have_http_status(200)
    end
  end
end
