require_relative '../../db/config'


class Legislator < ActiveRecord::Base

  validates :name, :party, :in_office, :title, presence: true
  # validates :phone 
  # validates :website
  # validates :webform


  def in_office?
    self.in_office == 1
  end

end