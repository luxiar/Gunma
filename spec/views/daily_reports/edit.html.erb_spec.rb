require 'rails_helper'

RSpec.describe 'daily_reports/edit', type: :view do
  let(:daily_report) do
    DailyReport.create!(
      title: 'MyString',
      content: 'MyString',
      mood: 'MyString'
    )
  end

  before(:each) do
    assign(:daily_report, daily_report)
  end

  it 'renders the edit daily_report form' do
    render

    assert_select 'form[action=?][method=?]', daily_report_path(daily_report), 'post' do

      assert_select 'input[name=?]', 'daily_report[title]'

      assert_select 'input[name=?]', 'daily_report[content]'

      assert_select 'input[name=?]', 'daily_report[mood]'
    end
  end
end
