require 'spec_helper'

describe Comment do
  let(:user) { FactoryGirl.create(:user) }
  let(:photo) { FactoryGirl.create(:photo, user_id:user.id, created_at: 1.day.ago) }
  before { @comment = photo.comments.build(content: "おもちかわいい", user_id:user.id) }

  subject { @comment }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:photo_id) }

  it { should be_valid }
end
