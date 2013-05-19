require 'spec_helper'

describe Api::ParticipantsController do
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
      @participant = create :participant
      sign_in users(:user)
    end

    describe '#index' do
      before :each do
        get :index
      end
      it { should respond_with :ok }
    end

    describe '#show' do
      before :each do
        get :show, :id => @participant.id
      end
      it { should respond_with :ok }
    end

    describe '#create' do
      before :each do
        post :create, :participant => {
          :first_name => 'bob',
          :last_name => 'jones',
          :gender => 'm',
          :birthday => '1983-06-01',
          :email => 'bob@example.com' }
      end
      it { should respond_with :success }
      it 'creates a participant' do
        expect(Participant.where(:email => 'bob@example.com').count).to eq(1)
      end
    end
  end
end
