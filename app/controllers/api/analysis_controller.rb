class Api::AnalysisController < ApplicationController
	before_filter :authenticate_user!
	before_filter :find_recording

  def create
    authorize! :update, @recording

    algorithm = params[:analysis][:algorithm]

    if algorithm != 'fft'
      return render :text => "unknown algorithm: #{algorithm}", :status => :bad_request
    end

    arguments = {
      :algo_id => algorithm,
      :args => {
        :input_file => @recording.data.expiring_url(10)
      }
    }

    jid = GoWorker.perform_async(arguments)

    @analysis = @recording.analyses.create!(
      :user => current_user,
      :jid => jid,
      :algorithm => algorithm,
      :arguments => arguments)

    render :json => @analysis, :status => :created
  end

protected
  def find_recording
    @recording = Recording.find(params[:recording_id])
  end

  def analysis_params
    params.require(:analysis).permit(:algorithm)
  end
end
