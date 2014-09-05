class Service < ActiveRecord::Base

	# belongs_to :user
	belongs_to :cleaner
	has_many :timings, dependent: :destroy
	accepts_nested_attributes_for :timings
end
