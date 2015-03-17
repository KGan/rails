require 'spec_helper'
require 'rails_helper'
require 'capybara'

feature "the signup process" do
  before(:each) do
    visit new_user_url
    fill_in 'Username', with: 'ur_mum'
  end
  it "has a new user page" do
    expect(page).to have_content 'Sign Up'
  end

  feature "signing up a user" do

    it "shows username on the homepage after signup" do
      fill_in 'Password', with: 'password'
      click_on 'Submit'
      expect(page).to have_content 'ur_mum'
    end

    it "invalidates empty username" do
      fill_in 'Username', with: ''
      click_on 'Submit'
      expect(page).to have_css('div.alert-errors')
    end

    it "invalidates empty password" do
      click_on 'Submit'
      expect(page).to have_css('div.alert-errors')
    end
  end

end

feature "logging in" do
  before(:each) do
    sign_up_as_your_mom
  end

  it "shows username on the homepage after login" do
    sign_in_as_your_mom
    expect(page).to have_content 'ur_mum'
  end

end

feature "logging out" do

  it "begins with logged out state" do
    visit root_url
    expect(page).to_not have_content 'ur_mum'
  end

  it "doesn't show username on the homepage after logout" do
    sign_up_as_your_mom
    sign_in_as_your_mom
    click_button 'Sign Out'
    expect(page).to_not have_content 'ur_mum'
  end

end
