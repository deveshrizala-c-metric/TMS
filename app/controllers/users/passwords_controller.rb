class Users::PasswordsController < Devise::PasswordsController
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  def create
    if params[:user][:email].blank?
      flash.now[:danger] = "Email can't be blank."
      self.resource = User.new
      render :new
    else
      self.resource = User.new(email: params[:user][:email])
      if validate_email(params[:user][:email])
        user = User.where('email = ?', params[:user][:email]).first
        if user.present?
          unless user.confirmed?
            flash.now[:danger] = 'To countinue please confirm your account.'
            render :new
          else
            super
          end
        else
          flash.now[:danger] = 'User does not exists.'
          render :new
        end
      else
        flash.now[:danger] = 'Invalid Email format.'
        render :new
      end
    end
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  # def update
  #   super
  # end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  def validate_email(email)
    (email =~ /^(([A-Za-z0-9])\w+(\.?|\-?|\+))+@{1}(([A-Za-z])\w*-?([A-Za-z])\w*?\.{1}){1,2}([A-Za-z])\w+$/) ? true : false
  end
end
