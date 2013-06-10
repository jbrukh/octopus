class Participant < ActiveRecord::Base
  include Trashable

  def self.search(query)
    term = "%#{query.downcase}%"
    self.where('lower(first_name) ILIKE ? or lower(last_name) ILIKE ? or lower(email) ILIKE ? ',
      term, term, term)
  end

  strip_attributes :allow_empty => true, :only => [:first_name, :last_name, :email]

  belongs_to  :user
  has_many    :recordings

  validates :first_name,  :presence => true
  validates :last_name,   :presence => true
  validates :email,       :presence => true, :uniqueness  => { :case_sensitive => false}
  validates :gender,      :presence => true, :inclusion   => { :in => %w(m f) }
  validates :birthday,    :presence => true
end
