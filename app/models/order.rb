class Order < ActiveRecord::Base
	belongs_to :user
	validates :location, presence: true , if: :active_or_timeplace?
	validates :number, :email, presence: true, if: :active_or_contact?
	validates_length_of :number, maximum: 8, if: :active_or_contact?
	validates_format_of :number, :with => /\A(9|8|6)\z/, :message => "Number should start with 9,8 or 6" , if: :active_or_contact?

	def active?
    	status == 'active'
	end

  	def active_or_timeplace?
    	status.include?('timeplace') || active?
  	end

  	def active_or_contact?
    	status.include?('contact') || active?
  	end

end