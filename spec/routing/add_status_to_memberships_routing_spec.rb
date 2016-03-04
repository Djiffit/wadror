require "rails_helper"

RSpec.describe AddStatusToMembershipsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/add_status_to_memberships").to route_to("add_status_to_memberships#index")
    end

    it "routes to #new" do
      expect(:get => "/add_status_to_memberships/new").to route_to("add_status_to_memberships#new")
    end

    it "routes to #show" do
      expect(:get => "/add_status_to_memberships/1").to route_to("add_status_to_memberships#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/add_status_to_memberships/1/edit").to route_to("add_status_to_memberships#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/add_status_to_memberships").to route_to("add_status_to_memberships#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/add_status_to_memberships/1").to route_to("add_status_to_memberships#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/add_status_to_memberships/1").to route_to("add_status_to_memberships#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/add_status_to_memberships/1").to route_to("add_status_to_memberships#destroy", :id => "1")
    end

  end
end
