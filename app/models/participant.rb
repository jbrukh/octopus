class Participant < ActiveRecord::Base
  belongs_to :user

  validates :first_name,  :presence => true
  validates :last_name,   :presence => true
  validates :email,       :presence => true
  validates :gender,      :presence => true, :inclusion => { :in => %w(m f) }
  validates :birthday,    :presence => true
end
