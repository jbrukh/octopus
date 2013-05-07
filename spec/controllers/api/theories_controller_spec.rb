require 'spec_helper'

describe Api::TheoriesController do
  describe 'as a guest' do
    describe '#index' do
      before do
        get :index
      end

      it { redirect_to new_user_session_url }
    end
  end
end
