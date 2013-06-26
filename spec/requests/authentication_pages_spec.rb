require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit signin_path }

    it { should have_content('ログイン') }
    it { should have_title('ログイン') }
    it { should_not have_link('Profile',  href: user_path(user)) }
    it { should_not have_link('Settings', href: edit_user_path(user)) }
    it { should_not have_link('Signout',  href: signout_path) }
  end

  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Signin" }

      it { should have_title('ログイン') }
      it { should have_selector('div.alert.alert-error', text: 'Invalid') }
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user }

      it { should have_title(user.name) }
      it { should have_link('Profile',    href: user_path(user)) }
      it { should have_link('Settings',   href: edit_user_path(user)) }
      it { should have_link('Signout',    href: signout_path) }
      it { should_not have_link('Signin', href: signin_path) }

      describe "should be root_path when signout" do
        before { click_link "Signout" }
        it { should have_title('comet') }
        it { should have_content("ログイン") }
      end
    end
  end

  describe "authorization" do
    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email",    with: user.email
          fill_in "Password", with: user.password
          click_button "Signin"
        end

        describe "after signing in" do

          it "should render the desired protected page" do
            expect(page).to have_title('設定変更')
          end

          describe "when signing in again" do
            before do
              delete signout_path
              visit signin_path
              fill_in "Email",  with:user.email
              fill_in "Password", with: user.password
              click_button "Signin"
            end

            it "should render the default (profile) page" do
              expect(page).to have_title(user.name)
            end
          end
        end
      end

      describe "in the Users controller" do
        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_title('comet') }
        end

        describe "submitting to the update action" do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end
      end
    end

    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before { sign_in non_admin }

      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete user_path(user) }
        specify { expect(response).to redirect_to(root_path) }
      end
    end
  end
end
