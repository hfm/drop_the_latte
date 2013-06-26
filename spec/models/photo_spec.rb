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
end
