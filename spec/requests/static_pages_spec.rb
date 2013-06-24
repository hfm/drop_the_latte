require 'spec_helper'

describe "Static pages" do

  let(:base_title) { "comet" }
  describe "Home page" do
    it "should have the content 'Sample App'" do
      visit '/static_pages/home'
      expect(page).to have_content('comet')
    end

    it "should have the title 'comet'" do
      visit '/static_pages/home'
      expect(page).to have_title("#{base_title} | Home")
    end
  end
end
