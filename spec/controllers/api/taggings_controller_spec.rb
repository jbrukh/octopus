require 'spec_helper'

describe Api::TaggingsController do
  fixtures :users

  let(:user) { users(:user) }
  let(:recording) { create :recording, :user => user }

  context 'as a guest' do
    describe '#index' do
      before :each do
        get :create, :recording_id => recording.id, :tagging => {}
      end
      it { should redirect_to new_user_session_url }
    end
  end

  context 'as a user' do
    before :each do
      sign_in users(:user)
    end

    describe '#create' do
      before :each do
        post :create, :recording_id => recording.id, :tagging => {
          :name => 'foo', :from_ms => 3000, :to_ms => 5000 }
      end

      it { should respond_with :created }
      it 'creates the tag' do
        expect(recording.reload.taggings.length).to be(1)
      end
    end
  end
end