class Api::AnalysisController < ApplicationController
	before_filter :authenticate_user!
	before_filter :find_recording

  def create
    authorize! :update, @recording

    payload = {
      :resource_ids => ['file1', 'file2'],
      :algo_id => params[:analysis][:algorithm],
      :args => {
        :sensitivity => 30,
        :something => "lolols"
      }
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
