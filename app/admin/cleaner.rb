ActiveAdmin.register Cleaner do

  index do
    column :name
    column "User" do |cleaner|
      cleaner.user.username
    end
    column "Number of Services" do |cleaner|
      cleaner.services.count
    end
    actions
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :name
    end

    f.inputs :for => [:user, f.object.user] do |user|
     user.input :username
     user.input :password
     user.input :password_confirmation
    
    end
 
    f.actions
  end

  controller do

    def new
      @cleaner = Cleaner.new
      @cleaner.build_user
    end

    def permitted_params
      params.permit cleaner: [:name, user_attributes: [:id, :username ,:email,:password,:password_confirmation]]
    end
    
  end

end
