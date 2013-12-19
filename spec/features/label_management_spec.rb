require 'spec_helper'

feature 'Label Management' do
  scenario 'User views labels' do
    visit labels_path
    expect(page).to have_content 'Abandoned Chats'
  end
  
  scenario 'User assigns label to first case' do
    visit labels_path
    page.first('[value="Assign to first case"]').click
    expect(page).to have_content 'Assigned label to first case'
  end
  
  scenario 'User creates a new label' do
    visit labels_path
    click_on 'Create a new label'
    
    label_name = SecureRandom.hex
    
    fill_in 'name', with: label_name
    fill_in 'description', with: 'Test Description'
    click_on 'Create Label'
    
    expect(page).to have_content 'Label succesfully created'
  end
  
  context 'when not valid' do
    scenario 'User creates a new label' do
      visit labels_path
      click_on 'Create a new label'
    
      # Don't fill anything out
      click_on 'Create Label'
      
      expect(page).to have_content 'Unable to create label'
    end
  end
end