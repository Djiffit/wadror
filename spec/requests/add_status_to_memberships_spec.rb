require 'rails_helper'

RSpec.describe "AddStatusToMemberships", type: :request do
  describe "GET /add_status_to_memberships" do
    it "works! (now write some real specs)" do
      get add_status_to_memberships_path
      expect(response).to have_http_status(200)
    end
  end
end
