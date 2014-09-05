ActiveAdmin.register Service do

  index do
    column :name
    column :description

    column "Cleaner" do |service|
      service.cleaner.name
    end

    # column "Timing" do |service|
    #   service.timings.each do |time|
    #     time.available_at
    #   end
    # end
    actions
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :cleaner
      f.input :name
      f.input :description

      f.has_many :timings, allow_destroy: true do |timing|
        timing.inputs "Add available timing" do
            timing.input :available_date, :as => :datepicker
            timing.input :available_from, :as => :time_picker
            timing.input :available_till, :as => :time_picker
          # timing.input :available_at, :as => :datepicker
        end
      end
    end
 
    f.actions
  end

  controller do

    def permitted_params
      params.permit service: [:name, :description, :cleaner_id, timings_attributes: [:id, :available_at, :_destroy]]
    end  
  end

end