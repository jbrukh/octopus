require 'spec_helper'

describe Api::ResultsController do
  fixtures :users

  let(:user) { users(:user) }
  let(:recording) { create :recording, user: user }

  context 'when guest' do
    context '#create' do
      before :each do
        post :create, :recording_id => recording.id
      end
      it { should redirect_to new_user_session_url }
    end
  end

  context 'when authenticated' do
    let(:file) { fixture_file_upload('files/odf.data', 'application/octet-stream') }

    before :each do
      sign_in users(:user)
    end

    context '#create' do
      before :each do
        post :create, :recording_id => recording.id, :result => { :data => file }
      end
      it { should respond_with :redirect }
      it { recording.reload.result.should_not be_nil }
    end
  end
end
