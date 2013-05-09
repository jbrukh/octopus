class Result < ActiveRecord::Base
  has_attached_file :data

  before_validation :update_duration

  protected
    def update_duration
      raw_odf = self.data.queued_for_write[:original]
      odf = Octopus::OdfReader.read(raw_odf)
      self.duration = odf.duration_ms
    end
end
