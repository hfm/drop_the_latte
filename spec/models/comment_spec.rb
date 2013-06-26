require 'spec_helper'

describe Comment do

  let(:user) { FactoryGirl.create(:user) }
  before do
    @comment = Comment.new(content: "おもちかわいい", user_id: user.id, photo_id: photo.id)
  end

  subject { @comment }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:photo_id) }
end
