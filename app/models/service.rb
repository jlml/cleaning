class Service < ActiveRecord::Base

	belongs_to :user
	has_many :timings, dependent: :destroy
	accepts_nested_attributes_for :timings
end
