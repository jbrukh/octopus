class Api::AnalysisController < ApplicationController
	before_filter :authenticate_user!
	before_filter :find_recording

  def create
    authorize! :update, @recording

    algo_id = params[:analysis][:algorithm]

    if algo_id != 'fft'
      return render :text => "unknown algorithm: #{algo_id}", :status => :bad_request
    end

    payload = {
      :algo_id => algo_id,
      :args => {
        :input_file => @recording.data.expiring_url(10)
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
