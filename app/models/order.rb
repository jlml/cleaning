class Order < ActiveRecord::Base
	belongs_to :user
	validates :location, :number, :email, presence: true
	validates_length_of :number, :maximum => 8
end