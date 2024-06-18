require 'rails_helper'

RSpec.describe "daily_reports/show", type: :view do
  before(:each) do
    assign(:daily_report, DailyReport.create!(
      title: "Title",
      content: "Content",
      mood: "Mood"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Content/)
    expect(rendered).to match(/Mood/)
  end
end
