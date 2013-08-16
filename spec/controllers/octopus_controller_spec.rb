require 'spec_helper'

describe OctopusController do
  fixtures :users

  context 'as a guest' do
    describe '#index' do
      before :each do
        get :index
      end

      it { should respond_with :redirect }
    end
  end

  context 'when authenticated' do
    let(:user) { users(:user) }

    before :each do
      sign_in users(:user)
    end

    context '#index' do
      before :each do
        get :index
      end

      it { should respond_with :ok }
    end
  end
end
