class Cleaner < ActiveRecord::Base
	has_one :user, as: :meta, dependent: :destroy
	accepts_nested_attributes_for :user

	has_many :services, dependent: :destroy
end
