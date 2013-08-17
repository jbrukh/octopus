class Api::ParticipantsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @participants = if params[:query]
      Participant.search(params[:query])
    else
      Participant.all
    end

    @participants = @participants.page(params[:page])

    render json: @participants, meta: {
      page: @participants.current_page,
      total_count: @participants.total_count,
      total_pages: @participants.total_pages
    }
  end

  def show
    @participant = Participant.find(params[:id])
    render json: @participant
  end

  def create
    @participant = Participant.new(participant_params)
    @participant.user = current_user
    if @participant.valid?
      @participant.save!
      render json: @participant
    else
      render json: @participant.errors, :serializer => ErrorsSerializer, :status => :unprocessable_entity
    end
  end

  def destroy
    @participant = Participant.find(params[:id])
    render json: @participant.trash!
  end

private
  def participant_params
    params.require(:participant).permit(:first_name, :last_name, :email, :gender, :birthday).tap do |whitelisted|
      whitelisted[:properties] = params[:participant][:properties]
    end
  end
end
