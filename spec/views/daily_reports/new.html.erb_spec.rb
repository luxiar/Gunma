require 'rails_helper'

RSpec.describe 'daily_reports/new', type: :view do
  before(:each) do
    assign(:daily_report, DailyReport.new(
      title: 'MyString',
      content: 'MyString',
      mood: 'MyString'
    ))
  end

  it 'renders new daily_report form' do
    render

    assert_select 'form[action=?][method=?]', daily_reports_path, 'post' do

      assert_select 'input[name=?]', 'daily_report[title]'

      assert_select 'input[name=?]', 'daily_report[content]'

      assert_select 'input[name=?]', 'daily_report[mood]'
    end
  end
end
