require 'spec_helper'

describe Photo do

  let(:user) { FactoryGirl.create(:user) }
  before { @photo = user.photos.build(took_date:DateTime.new(2011, 12, 24, 00, 00, 00)) }

  subject { @photo }

  it { should respond_to(:took_date) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @photo.user_id = nil }
    it { should_not be_valid }
  end

  describe "when took_date is not present" do
    before { @photo.took_date = " " }
    it { should_not be_valid }
  end

  describe "comments associations" do
    before { @photo.save }
    let!(:old_comment) { FactoryGirl.create(:comment, photo:@photo, user_id:user.id, created_at: 1.day.ago) }
    let!(:new_comment) { FactoryGirl.create(:comment, photo:@photo, user_id:user.id, created_at: 1.hour.ago) }

    it "shourd have the right comments in the right order" do
      expect(@photo.comments.to_a).to eq [new_comment, old_comment]
    end

    it "should destroy associated comments" do
      comments = @photo.comments.to_a
      @photo.destroy
      expect(comments).not_to be_empty
      comments.each do |comment|
        expect(Comment.where(id: comment.id)).to be_empty
      end
    end
  end
end
