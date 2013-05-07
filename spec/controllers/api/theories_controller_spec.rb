require 'spec_helper'

describe Api::TheoriesController do
  describe 'as a guest' do
    describe '#index' do
      before :each do
        get :index
      end
      it { should redirect_to new_user_session_url }
    end
  end

  describe 'as a user' do
    before :each do
      sign_in users(:bob)
    end

    describe '#index' do
      before :each do
        get :index
      end

      it { should_respond_with :success }
    end
  end
end
