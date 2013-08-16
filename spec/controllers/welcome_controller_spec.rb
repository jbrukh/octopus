require 'spec_helper'

describe WelcomeController do
  context 'unauthenticated' do
    describe '#index' do
      before :each do
        get :index
      end

      it { should respond_with :ok }
    end
  end
end
