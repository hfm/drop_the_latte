require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit signin_path }

    it { should have_content('ログイン') }
    it { should have_title('ログイン') }
    it { should_not have_link('プロフィール',  href: user_path(user)) }
    it { should_not have_link('設定', href: edit_user_path(user)) }
    it { should_not have_link('サインアウト',  href: signout_path) }
  end

  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "ログイン" }

      it { should have_title('ログイン') }
      it { should have_selector('div.alert.alert-error', text: 'メールまたはパスワードが違います') }
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user }

      it { should have_title("ダッシュボード") }
      it { should have_selector('li.user') }
      it { should have_selector('li.setting') }
      it { should have_selector('li.logout') }
      it { should_not have_link('サインイン', href: signin_path) }

      describe "should be root_path when signout" do
        before { find("#logout").click }
        it { should have_title('comet') }
        it { 
          pending "ログインがテスト上で認識されないため保留"
          should have_content("ログイン") 
        }
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
          click_button "ログイン"
        end

        describe "after signing in" do

          it "should render the desired protected page" do
            expect(page).to have_title('設定変更')
          end

          pending "when signing in again" do
            before do
              delete signout_path
              visit signin_path
              fill_in "Email",    with: user.email
              fill_in "Password", with: user.password
              click_button "ログイン"
            end

            it "should render the default (profile) page" do
              expect(page).to have_title("ダッシュボード")
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

      describe "in the Photos controller" do
        describe "submitting to the create action" do
          before { post photos_path }
          specify { expect(response).to redirect_to(signin_path) }
        end

        describe "submitting to the destroy action" do
          before { delete photo_path(FactoryGirl.create(:photo)) }
          specify { expect(response).to redirect_to(signin_path) }
        end
      end

      describe "in the Comments controller" do
        pending "submitting to the create action" do
          before { post comments_path }
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
