class Users::RegistrationsController < Devise::RegistrationsController
# before_action :configure_sign_up_params, only: [:create]
# before_action :configure_account_update_params, only: [:update]


before_action :configure_permitted_parameters, if: :devise_controller?

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    u = User.only_deleted.where("email = ?", params[:user][:email])

    if u.present?
      flash[:danger] = 'User Deleted. Please Contact Admin.'
      redirect_to new_user_session_path
    else
      # if valid_email(params[:user][:email]) == true
        super
      # end
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   if valid_email(params[:user][:email])
  #     super
  #   end
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected
  def configure_permitted_parameters
    if params[:action] == 'update'
      devise_parameter_sanitizer.permit(:account_update, keys: [:fullname,:phone])
    elsif params[:action] == 'create'
      devise_parameter_sanitizer.permit(:sign_up, keys: [:fullname,:phone])
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.

  def after_update_path_for(resource)
    flash[:notice] = "Profile updated successfully"
    home_path
  end

  def after_inactive_sign_up_path_for(resource)
    # super(resource)
    flash.delete(:notice)
    flash[:info] = "A message with a confirmation link has been sent to your email address. Please follow the link to activate your account."
    new_user_session_path
  end

  private
  def valid_email(email)
    if email.blank?
        flash[:danger] = 'Email can not be blank.'
        redirect_to new_user_registration_path
        # render :new
    else
      if validate_email(email)
        true
      else
        flash[:danger] = 'Invaild Email Format.'
        redirect_to new_user_registration_path
        # render :new
      end
    end
  end

  def validate_email(email)
    (email =~ /^(([A-Za-z0-9])\w+(\.?|\-?|\+))+@{1}(([A-Za-z])\w*-?([A-Za-z])\w*?\.{1}){1,2}([A-Za-z])\w+$/) ? true : false
  end
end
