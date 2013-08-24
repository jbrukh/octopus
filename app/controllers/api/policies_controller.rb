class Api::PoliciesController < ApplicationController
  before_filter :authenticate_user!

  before_filter :find_recording

  def show
    authorize! :update, @recording

    if @recording.uploaded?
      render :text => "Recording has already been uploaded", :status => :bad_request
    else
      policy = s3_upload_policy_document

      encoded = Base64.encode64(policy.to_json).gsub("\n","")
      signature = Base64.encode64(
        OpenSSL::HMAC.digest(
            OpenSSL::Digest::Digest.new('sha1'),
            ENV['S3_SECRET_ACCESS_KEY'], encoded)
        ).gsub("\n","")

      render json: { :policy => {:contents => encoded, :signature => signature} }
    end
  end

private

  def s3_upload_policy_document
    {
      expiration: 30.minutes.from_now.utc.strftime('%Y-%m-%dT%H:%M:%S.000Z'),
      conditions: [
        { bucket: ENV['S3_BUCKET_NAME'] },
        { acl: 'private' },
        [ "starts-with", "$key", "recordings/"],
        { success_action_redirect: 'http://localhost/' },
        [ "starts-with", "$Content-Type", "application/octet-stream" ],
        [ "content-length-range", 0, 104857600]
      ]
    }
  end

  def find_recording
    @recording = Recording.find(params[:id])
  end
end
