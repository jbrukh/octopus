class Participant < ActiveRecord::Base
  include Trashable

  def self.search(query)
    t = Participant.arel_table
    condition = t[:first_name].eq(query)
      .or(t[:last_name].eq(query))
      .or(t[:email].eq(query))

    self.where(condition)
  end

  belongs_to :user

  validates :first_name,  :presence => true
  validates :last_name,   :presence => true
  validates :email,       :presence => true, :uniqueness  => { :case_sensitive => false}
  validates :gender,      :presence => true, :inclusion   => { :in => %w(m f) }
  validates :birthday,    :presence => true
end
