class Order < ActiveRecord::Base
	belongs_to :user
	validates :location, presence: true , if: :active_or_timeplace?
	validates :number, :email, presence: true, if: :active_or_contact?
	validates_length_of :number, maximum: 8, if: :active_or_contact?
	validates_format_of :number, :with => /\A[986]\w+\z/, :message => "Number should start with 9,8 or 6" , if: :active_or_contact?

	def active?
    status == 'active'
	end

	def active_or_timeplace?
  	status.include?('timeplace') || active?
	end

	def active_or_contact?
  	status.include?('contact') || active?
	end

	def available_date
		available_date =  Timing.all.map {|date| date.available_date.strftime("%d, %B, %Y ")}
	end

	def available_time(date, time_required)
		dates = Timing.where("available_date.to_date =?", date.to_date)
		timings = []
		date.each do |date|
			available_time = (date.available_from - date_available_till)/3600
			if available_time >= time_required
				timings << date
			end
		end
		return timings
	end

end