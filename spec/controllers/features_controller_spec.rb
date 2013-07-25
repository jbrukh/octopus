require 'spec_helper'

describe FeaturesController do

  describe '#show' do
    describe "with valid feature" do
      before :each do
        get :show, :id => 'tagging'
      end
      it { should respond_with :ok }
    end

    describe "with invalid feature" do
      it do
        expect { get :show, :id => 'fibble' }.to raise_error(ActionController::RoutingError)
      end
    end
  end

end
