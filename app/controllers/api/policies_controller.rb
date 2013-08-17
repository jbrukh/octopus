require 'aws-sdk'

class Api::PoliciesController < ApplicationController
  def index
    policy = AWS::Core::Policy.new
    policy.allow(
      :actions => ['s3:PutObject'],
      :resources => "arn:aws:s3:::mybucket/mykey/*",
      :principals => :any
    ).where(:acl).is("public-read")

    encoded = Base64.encode64(policy.to_json).gsub("\n","")
    signature = Base64.encode64(
      OpenSSL::HMAC.digest(
          OpenSSL::Digest::Digest.new('sha1'),
          ENV['S3_SECRET_ACCESS_KEY'] || 'abcd', encoded)
      ).gsub("\n","")

    render json: {:encoded => policy.to_json, :signature => signature}
  end
end
