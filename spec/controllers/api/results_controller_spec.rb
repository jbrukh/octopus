require 'spec_helper'

describe Api::ResultsController do
  fixtures :users

  let(:user) { users(:user) }
  let(:recording) { create :recording, user: user }

  context 'when guest' do
    context '#update' do
      before :each do
        post :update, :id => recording.id
      end
      it { should redirect_to new_user_session_url }
    end
  end

  context 'when authenticated' do
    before :each do
      sign_in users(:user)
    end

    context '#update (with direct upload)' do
      before :each do
        ProcessResultWorker.expects(:perform_async).once
        data = Rack::Test::UploadedFile.new(
          "#{Rails.root}/spec/fixtures/files/obf.data", 'application/octet-stream')
        post :update, :id => recording.id, :result => { :data => data }
      end
      it { should respond_with :created }
      it 'updates the recording' do
        recording.reload
        expect(recording.data).not_to eq(nil)
        expect(recording.uploaded?).to eq(true)
      end
    end

    context '#update (with external upload)' do
      before :each do
        ProcessResultWorker.expects(:perform_async).once

        post :update, :id => recording.id, :result => {
          :data_file_name => 'filename',
          :data_content_type => 'application/octet-stream',
          :data_file_size => 12345 }
      end
      it { should respond_with :created }
      it 'updates the recording' do
        recording.reload
        expect(recording.data).not_to eq(nil)
        expect(recording.uploaded?).to eq(true)
        expect(recording.data.original_filename).to eq('filename')
        expect(recording.data.size).to eq(12345)
      end
    end
  end
end
