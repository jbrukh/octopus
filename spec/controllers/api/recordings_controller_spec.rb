require 'spec_helper'

describe Api::RecordingsController do
  fixtures :users

  let (:participant) { create :participant, :user => users(:user) }
  let (:participant_unauthorized) { create :participant, :user => users(:stranger) }

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

    describe '#index (with participant id)' do
      before :each do
        get :index, :participant_id => participant.id
      end

      it { should respond_with :ok }
    end

    describe '#index (with unauthorized participant id)' do
      it do
        expect { get :index, :participant_id => participant_unauthorized.id }.to raise_error
      end
    end

    describe '#create' do
      before :each do
        post :create, :recording => { :duration_ms => 5000 }
      end

      it { should respond_with :created }
      it { expect(Recording.last.duration_ms).to eq(5000) }
    end

    describe '#create (with participant)' do
      before :each do
        post :create, :recording => { :participant_id => participant.id }
      end

      it { should respond_with :created }
      it 'created a recording with a participant' do
        expect(Recording.last.participant).not_to eq(nil)
      end
    end

    context 'with organization recording' do
      before :each do
        @recording = users(:friend).recordings.build
        Recording.stub_chain(:includes, :find).and_return(@recording)
      end

      describe '#show' do
        it 'gets record' do
          post :show, :id => 5
        end
      end
    end

    context 'with enemy recording' do
      before :each do
        @recording = users(:enemy).recordings.build
        Recording.stub_chain(:includes, :find).and_return(@recording)
      end

      describe '#show' do
        it do
          expect { post :show, :id => 5 }.to raise_error
        end
      end
    end

    context 'with stranger recording' do
      before :each do
        @recording = users(:stranger).recordings.build
        Recording.stub_chain(:includes, :find).and_return(@recording)
      end

      describe '#show' do
        it do
          expect { post :show, :id => 5 }.to raise_error
        end
      end
    end

    context 'with recording' do
      before :each do
        @recording = users(:user).recordings.build
        Recording.stub_chain(:includes, :find).and_return(@recording)
      end

      describe '#show' do
        it 'gets record' do
          post :show, :id => 5
        end
      end

      describe '#update' do
        it 'updates the recording' do
          @recording.should_receive(:update_attributes!).once
          put :update, :id => 5, :recording => {:description => 'foo'}
        end
      end

      describe '#destroy' do
        it 'trashes record' do
          @recording.should_receive(:trash!).once
          post :destroy, :id => 5
        end
      end
    end
  end
end
