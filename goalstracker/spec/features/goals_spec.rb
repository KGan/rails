require 'spec_helper'
require 'rails_helper'
require 'capybara'

feature "Goals" do
  before(:each) do
    sign_up_as_your_mom
  end

  it "Shows New Goal Page" do
    visit new_goal_url
    expect(page).to have_content 'New Goal'
  end

  it "can't be reached if not logged in" do
    click_button 'Sign Out'
    visit new_goal_url
    expect(page).to have_content 'Sign In'
  end

  feature 'New Goals' do
    it "allows creation of new valid goal" do

      create_goal('do your mom')
      expect(page).to_not have_css('div.alert-errors')
    end

    it "rejects no goal text" do
      create_goal('')
      expect(page).to have_css 'div.alert-errors'
    end
  end

  feature 'on creating' do
    feature 'a private goal' do
      let!(:goal) { FactoryGirl.create(:goal, :goaltype => 'PRIVATE') }

      before(:each) do
        visit user_goals_url(goal.user_id)
      end

      it 'is visible to creator' do
        expect(page).to have_content(goal.title)
      end

      feature 'can be edited by creator' do
        it 'shows edit button' do
          expect(page).to have_button 'Edit Goal'
          click_button 'Edit Goal'
          expect(page).to have_css('form.edit-goal')
        end

        it 'can update' do
          click_button 'Edit Goal'
          fill_in('Goal', with: "I really don't care")
          click_button 'Submit'
          expect(page).to have_content("I really don't care")
        end
      end

      it 'is invisible to another user' do
        click_button 'Sign Out'
        sign_up('someone_else')
        visit '/users/1/goals'
        expect(page).to_not have_content(goal.title)
      end
    end

    feature 'a public goal' do
      let!(:goal) { FactoryGirl.create(:goal, :goaltype => 'PUBLIC') }

      it 'is visible to another user' do
        click_button 'Sign Out'
        sign_up('someone_else')
        visit '/users/1/goals'
        expect(page).to have_content(goal.title)
      end
    end
  end
end
