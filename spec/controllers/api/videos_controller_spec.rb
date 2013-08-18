require 'spec_helper'

describe Api::VideosController do
  fixtures :users

  let(:user)  { users(:user) }

  context 'when guest' do
    context '#create' do
      before :each do
        post :create, :video => {:name => 'stupid feline'}
      end
      it { should redirect_to new_user_session_url }
    end
  end

  context 'when authenticated' do
    before :each do
      sign_in users(:user)
    end

    describe '#create' do
      before :each do
        data = Rack::Test::UploadedFile.new(
          "#{Rails.root}/spec/fixtures/files/dizzy.mp4", 'video/mp4')
        post :create, :video => { :name => 'stupid feline', :data => data }
      end
      it { should respond_with :created }
    end

    context 'with recording' do
      before :each do
        @video = build :video
        Video.stub(:find).and_return(@video)
      end

      describe '#destroy' do
        it 'trashes video' do
          @video.should_receive(:trash!).once
          post :destroy, :id => 5
        end
      end
    end
  end
end
