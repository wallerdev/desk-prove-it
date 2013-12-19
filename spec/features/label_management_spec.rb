require 'spec_helper'

feature 'Label Management' do
  scenario 'User views labels' do
    visit labels_path
    expect(page).to have_content 'Abandoned Chats'
  end
end