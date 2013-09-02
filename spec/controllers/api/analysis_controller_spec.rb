require 'spec_helper'

describe Api::AnalysisController do
  fixtures :users

  context 'as a guest' do
    describe '#create' do
      before :each do
        post :create, :recording_id => 30, :analysis => { :algorithm => 'fft' }
      end
      it { should redirect_to new_user_session_url }
    end
  end

  context 'as a user' do
    let (:user) { users(:user) }
    let (:recording) { create :recording, :user => user }

    before :each do
      sign_in user
      expect(Recording).to receive(:find) { recording }
    end

    describe '#create' do
      before :each do
        expect(GoWorker).to receive(:perform_async) { 12345 }
        post :create, :recording_id => recording.id, :analysis => { :algorithm => 'fft' }
      end

      it { should respond_with :created }
    end

    describe '#create (with unknown algorithm)' do
      before :each do
        post :create, :recording_id => recording.id, :analysis => { :algorithm => 'unknown' }
      end

      it { should respond_with :unprocessable_entity }
    end
  end
end
