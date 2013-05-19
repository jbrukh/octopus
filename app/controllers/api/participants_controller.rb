class Api::ParticipantsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @participants = Participant.all
    render json: @participants
  end

  def create
    @participant = Participant.new(participant_params)
    @participant.user = current_user
    @participant.save!
    render json: @participant
  end

  private
    def participant_params
      params.require(:participant).permit(:first_name, :last_name, :email, :gender, :birthday)
    end
end
