class Api::AnalysisController < ApplicationController
	before_filter :authenticate_user!
	before_filter :find_recording

  def create
    authorize! :update, @recording

    @analysis = @recording.analyses.build(analysis_params)
    @analysis.user = current_user

    if @analysis.valid?
      @analysis.save!

      jid = GoWorker.perform_async(
        :analysis_id => @analysis.id
        :algo_id => @analysis.algorithm,
        :args => @analysis.arguments
      )

      @analysis.dispatch!(jid)

      render json: @analysis, :status => :created
    else
      render json: @analysis.errors, :serializer => ErrorsSerializer, :status => :unprocessable_entity
    end
  end

protected
  def find_recording
    @recording = Recording.find(params[:recording_id])
  end

  def analysis_params
    params.require(:analysis).permit(:algorithm)
  end
end
