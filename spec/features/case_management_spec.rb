require 'spec_helper'

feature 'Case Management' do
  scenario 'User views cases' do
    visit cases_path
    expect(page).to have_content 'Welcome to Desk.com'
  end
end