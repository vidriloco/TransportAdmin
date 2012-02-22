class Vehicle < ActiveRecord::Base
  belongs_to :line
  has_many :instants
end
