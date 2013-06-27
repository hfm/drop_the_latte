require 'spec_helper'

describe "Comment pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  pending "comment creation" do
    before { visit user_path(user) }

    describe "with invalid information" do

      it "should not create a comment" do
        expect { click_link "コメント" }.not_to change(Comment, :count)
      end

      describe "error messages" do
        before { click_link "コメント" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before { fill_in 'comment_content', with: "Lorem ipsum" }
      it "should create a comment" do
        expect { click_link "コメント" }.to change(Comment, :count).by(1)
      end
    end
  end
end
