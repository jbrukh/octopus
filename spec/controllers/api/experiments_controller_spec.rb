require 'spec_helper'

describe Api::ExperimentsController do
  fixtures :users

  let (:media) { create :video, :user => users(:user) }

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
        post :create, :experiment => { :name => 'name', :media_id => media.id }
      end
      it { should respond_with :created }
    end
  end
end
