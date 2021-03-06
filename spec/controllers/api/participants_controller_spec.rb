require 'spec_helper'

describe Api::ParticipantsController do
  fixtures :users

  let(:user) { users(:user) }

  context 'as a guest' do
    describe '#index' do
      before :each do
        get :index
      end
      it { should redirect_to new_user_session_url }
    end
  end

  context 'as a user' do
    let(:participant) { create :participant, :user => user }

    before :each do
      sign_in user
    end

    describe '#index' do
      before :each do
        Participant.stub_chain(:all, :viewable_by, :page).and_return(stub_pagination([@participant]))
        get :index
      end
      it { should respond_with :ok }
    end

    describe '#index (with query param)' do
      before :each do
        Participant.stub_chain(:search, :viewable_by, :page).and_return(stub_pagination([@participant]))
        get :index, :query => 'Bob Jones'
      end

      it { should respond_with :ok }
    end

    describe '#show' do
      before :each do
        get :show, :id => participant.id
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
          :email => 'bob@example.com',
          :properties => {
            :key => 'value', :key2 => 'value2'
            }
          }
      end
      it { should respond_with :success }
      it 'creates a participant' do
        expect(Participant.where(:email => 'bob@example.com').count).to eq(1)
      end
      it 'creates properties' do
        participant = Participant.find_by_email('bob@example.com')
        expect(participant.properties.length).to eq(2)
      end
    end

    describe '#create (invalid)' do
      before :each do
        post :create, :participant => {
          :gender => 'm',
          :birthday => '1983-06-01',
          :email => 'bob@example.com',
          :properties => {
            :key => 'value', :key2 => 'value2'
            }
          }
      end
      it { should respond_with :unprocessable_entity }
    end

    context 'with participant' do
      before :each do
        @participant = build :participant, user: user
        Participant.stub(:find).and_return(@participant)
      end

      describe '#destroy' do
        it 'trashes record' do
          @participant.should_receive(:trash!).once
          post :destroy, :id => 5
        end
      end
    end
  end
end
