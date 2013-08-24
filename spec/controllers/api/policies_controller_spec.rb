require 'spec_helper'

describe Api::PoliciesController do
  fixtures :users

  let(:user) { users(:user) }
  let(:enemy) { users(:enemy) }

  before :each do
    ENV.stub(:[]).with("S3_BUCKET_NAME").and_return("bucket-name")
    ENV.stub(:[]).with("S3_SECRET_ACCESS_KEY").and_return("secret")
  end

  context 'as a guest' do
    let(:recording) { create :recording, user: user }

    describe '#show' do
      before :each do
        get :show, :id => recording.id
      end
      it { should redirect_to new_user_session_url }
    end
  end

  context 'as a user' do
    before :each do
      sign_in user
    end

    describe '#show' do
      let(:recording) { create :recording, user: user }

      before :each do
        get :show, :id => recording.id
      end
      it { should respond_with :ok }
    end

    describe '#show (when already uploaded)' do
      let(:recording) { create :recording, user: user, state: 'uploaded' }

      before :each do
        get :show, :id => recording.id
      end
      it { should respond_with :bad_request }
    end

    describe '#show (for enemy recording)' do
      let(:enemy_recording) { create :recording, user: enemy }
      it { expect { get :show, :id => enemy_recording.id }.to raise_error }
    end
  end
end
