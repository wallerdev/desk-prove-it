require 'spec_helper'

feature 'Menu' do
  scenario 'User views cases' do
    visit root_path
    click_on 'Cases'
    expect(page).to have_css 'table#cases'
  end
end