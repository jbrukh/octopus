require 'spec_helper'

describe Api::SlideshowsController do
  fixtures :users

  let(:user)  { users(:user) }

  context 'when guest' do
    context '#create' do
      before :each do
        post :create, :slideshow => {:name => 'stupid feline'}
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
        post :create, :slideshow => { :name => 'awesome slideshow' }
      end
      it { should respond_with :created }
    end
  end
end
