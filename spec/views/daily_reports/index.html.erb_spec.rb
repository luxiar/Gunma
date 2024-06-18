require 'rails_helper'

RSpec.describe 'daily_reports/index', type: :view do
  before(:each) do
    assign(:daily_reports, [
      DailyReport.create!(
        title: 'Title',
        content: 'Content',
        mood: 'Mood'
      ),
      DailyReport.create!(
        title: 'Title',
        content: 'Content',
        mood: 'Mood'
      )
    ])
  end

  it 'renders a list of daily_reports' do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new('Title'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('Content'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('Mood'.to_s), count: 2
  end
end
