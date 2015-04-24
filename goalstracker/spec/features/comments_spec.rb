require 'spec_helper'
require 'rails_helper'
require 'capybara'

feature "Comments" do
  before(:each) do
    sign_up_as_your_mom
    @mom = User.first
    @goal = FactoryGirl.create(:goal, :goaltype=> 'PUBLIC', :user_id => @mom.id)
    click_button 'Sign Out'
    sign_up('commenter')
  end
  it "can be added to users" do
    visit_showpage(@mom)
    expect(page).to have_css('textarea.comment-body')
  end
  it "can be added to goals" do
    visit_showpage(@goal)
    expect(page).to have_css('textarea.comment-body')
  end

  feature "Previously entered comments (on users)" do
    it "are visible on User show page" do
      body = create_comment_for(@mom)
      expect(page).to have_content(body)
    end
  end

  feature "Previously entered comments (on goals)" do
    it "are visible on User Goals page" do
      body = create_comment_for(@goal)
      expect(page).to have_content(body)
    end
  end
end
