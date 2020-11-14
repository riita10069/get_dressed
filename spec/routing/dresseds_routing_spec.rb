require "rails_helper"

RSpec.describe DressedsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/dresseds").to route_to("dresseds#index")
    end

    it "routes to #new" do
      expect(:get => "/dresseds/new").to route_to("dresseds#new")
    end

    it "routes to #show" do
      expect(:get => "/dresseds/1").to route_to("dresseds#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/dresseds/1/edit").to route_to("dresseds#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/dresseds").to route_to("dresseds#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/dresseds/1").to route_to("dresseds#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/dresseds/1").to route_to("dresseds#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/dresseds/1").to route_to("dresseds#destroy", :id => "1")
    end
  end
end
