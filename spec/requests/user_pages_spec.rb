require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    let(:other) { FactoryGirl.create(:user) }
    let(:p) { FactoryGirl.create(:photo, user:user) }
    let(:c) { FactoryGirl.create(:comment, photo:p, user_id:user.id, other_id:other.id) }

    before { visit user_path(user) }

    it { should have_title("ダッシュボード") }
  end

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('ユーザー登録') }
    it { should have_title(full_title('登録')) }
  end

  describe "signup" do
    before { visit signup_path }
    let(:submit) { "登録" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_title('登録') }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_selector('li.logout') }
        it { should have_title('ダッシュボード') }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_content("Update your profile") }
      it { should have_title("設定変更") }
    end

    describe "with invalid information" do
      before { click_button "変更" }

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Name",             with: new_name
        fill_in "Email",            with: new_email
        fill_in "Password",         with: user.password
        fill_in "Confirmation", with: user.password
        click_button "変更"
      end

      it { should have_title("ダッシュボード") }
      it { should have_selector('div.alert.alert-success') }
      it { should have_selector('li.user') }
      it { should have_selector('li.setting') }
      it { should have_selector('li.logout') }
      specify { expect(user.reload.name).to  eq new_name }
      specify { expect(user.reload.email).to eq new_email }
    end
  end
end
