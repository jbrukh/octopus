class Api::AnalysisController < ApplicationController
	before_filter :authenticate_user!
	before_filter :find_recording

  def create
    authorize! :update, @recording

    payload = {
      :resources => [
        { :name => 'raw', :location => @recording.data.expiring_url(10) }
      ],
      :algo_id => params[:analysis][:algorithm],
      :args => { }
    }

    GoWorker.perform_async(payload)

    render :text => "created analysis", :status => :created
  end

protected
  def find_recording
    @recording = Recording.find(params[:recording_id])
  end

  def analysis_params
    params.require(:analysis).permit(:algorithm)
  end
end
