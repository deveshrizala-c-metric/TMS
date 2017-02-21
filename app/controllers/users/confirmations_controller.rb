class Users::ConfirmationsController < Devise::ConfirmationsController
  # GET /resource/confirmation/new
  # def new
  #   super
  # end

  # POST /resource/confirmation
  def create
    if params[:user][:email].blank?
      flash[:danger] = "Email can't be blank."
      redirect_to new_user_confirmation_path
    else
      if validate_email(params[:user][:email])
        super
      else
        flash[:danger] = 'Invalid Email format.'
        redirect_to new_user_confirmation_path
      end
    end
  end

  # GET /resource/confirmation?confirmation_token=abcdef
  # def show
  #   super
  # end

  # protected

  # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  # The path used after confirmation.
  # def after_confirmation_path_for(resource_name, resource)
  #   super(resource_name, resource)
  # end

  def validate_email(email)
    (email =~ /^(([A-Za-z0-9])\w+(\.?|\-?|\+))+@{1}(([A-Za-z])\w*-?([A-Za-z])\w*?\.{1}){1,2}([A-Za-z])\w+$/) ? true : false
  end
end
