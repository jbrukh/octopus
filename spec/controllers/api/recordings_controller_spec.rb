require 'spec_helper'

describe Api::RecordingsController do
  fixtures :users

  context 'as a guest' do
    describe '#index' do
      before :each do
        get :index
      end
      it { should redirect_to new_user_session_url }
    end
  end

  context 'as a user' do
    before :each do
      sign_in users(:user)
    end

    describe '#index' do
      before :each do
        get :index
      end

      it { should respond_with :ok }
    end

    describe '#create' do
      before :each do
        post :create
      end

      it { should respond_with :created }
    end

    context 'with recording' do
      before :each do
        @recording = users(:user).recordings.build
        Recording.expects(:find).returns(@recording)
      end

      describe '#destroy' do
        it 'trashes record' do
          @recording.expects(:trash!).at_least_once
          post :destroy, :id => 5
        end
      end

      describe '#update' do
        it 'updates teh recording' do
          @recording.expects(:update_attributes!).once
          put :update, :id => 5, :recording => {:description => 'foo'}
        end
      end
    end
  end
end
