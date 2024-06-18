require "rails_helper"

RSpec.describe DailyReportsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/daily_reports").to route_to("daily_reports#index")
    end

    it "routes to #new" do
      expect(get: "/daily_reports/new").to route_to("daily_reports#new")
    end

    it "routes to #show" do
      expect(get: "/daily_reports/1").to route_to("daily_reports#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/daily_reports/1/edit").to route_to("daily_reports#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/daily_reports").to route_to("daily_reports#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/daily_reports/1").to route_to("daily_reports#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/daily_reports/1").to route_to("daily_reports#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/daily_reports/1").to route_to("daily_reports#destroy", id: "1")
    end
  end
end
