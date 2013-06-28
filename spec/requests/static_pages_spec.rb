require 'spec_helper'

describe "Static pages" do
  subject { page }

  shared_examples_for "all static pages" do
    it { should have_content(heading) }
    it { should have_title(full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path }
    let(:heading) { '' }
    let(:page_title) { '' }

    it_should_behave_like "all static pages"
    it { should_not have_title('| Home') }
    it { should have_content('登録がお済みでない方はこちら') }
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "登録"
    expect(page).to have_title(full_title('登録'))
  end

  describe "When signed in" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit root_path
    end

    it { should have_title("ダッシュボード") }
  end
end
