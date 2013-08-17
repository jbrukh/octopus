class Api::PoliciesController < ApplicationController
  def show
    policy = s3_upload_policy_document

    encoded = Base64.encode64(policy.to_json).gsub("\n","")
    signature = Base64.encode64(
      OpenSSL::HMAC.digest(
          OpenSSL::Digest::Digest.new('sha1'),
          ENV['S3_SECRET_ACCESS_KEY'], encoded)
      ).gsub("\n","")

    render json: { :policy => {:contents => encoded, :signature => signature} }
  end

private

  def s3_upload_policy_document
    {
      expiration: 30.minutes.from_now.utc.strftime('%Y-%m-%dT%H:%M:%S.000Z'),
      conditions: [
        { bucket: ENV['S3_BUCKET_NAME'] },
        { acl: 'private' },
        ["starts-with", "$key", "recordings/"],
        { success_action_redirect: 'http://localhost/' },
        { 'content-type': 'application/octet-stream' },
        ["content-length-range", 0, 104857600]
      ]
    }
  end
end
