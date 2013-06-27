require 'spec_helper'

describe Comment do
  let(:user) { FactoryGirl.create(:user) }
  let(:other) { FactoryGirl.create(:user) }
  let(:photo) { FactoryGirl.create(:photo, user_id:user.id, other_id:other.id, created_at: 1.day.ago) }
  before { @comment = photo.comments.build(content: "おもちかわいい", user_id:user.id, other_id:other.id) }

  subject { @comment }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:other_id) }
  it { should respond_to(:photo_id) }
  its(:user) { should eq user }
  its(:photo) { should eq photo }

  it { should be_valid }

  describe "validation" do
    context "when user_id is not present" do
      before { @comment.user_id = nil }
      it { should_not be_valid }
    end

    context "when other_id is not present" do
      before { @comment.other_id = nil }
      it { should_not be_valid }
    end

    context "when photo_id is not present" do
      before { @comment.photo_id = nil }
      it { should_not be_valid }
    end
  end

  describe "with blank content" do
    before { @comment.content = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @comment.content = "a" * 141 }
    it { should_not be_valid }
  end
end
