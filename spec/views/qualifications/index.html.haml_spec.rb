require 'rails_helper'

RSpec.describe "qualifications/index.html.haml", :type => :view do
  before :each do
    @qualifications = JSON.parse sample_json
    assign :qualifications, @qualifications
  end

  it 'renders the list of qualifications from the json to html' do
    render

    assert_select 'ul>li>a', text: @qualifications.first['name'], count: 1
  end

  it 'for each qualification renders the list of subjects with color style' do
    render

    assert_select 'ul>li>.subjects>ul>li',
        text: @qualifications.first['subjects'].first['title'], count: 1
    assert_select 'ul>li>.subjects>ul>li',
        style: Regexp.new(@qualifications.first['subjects'].first['colour']), count: 1
  end
end
