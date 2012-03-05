require 'acceptance/acceptance_helper'

feature 'Visualizations preview: '  do
  
  scenario "should let me see the visualizations" do
    visit visualizations_path
    
    click_on I18n.t('visualizations.index.title')
    page.should have_content I18n.t('visualizations.index.title')
  end
  
end