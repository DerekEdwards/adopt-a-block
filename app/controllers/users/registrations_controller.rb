# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  before_action :authenticate_user!, only: [:edit, :update]

  # GET /resource/sign_up
  def new 
    @block_id = params[:block_id]
    @neighborhood_id = params[:neighborhood_id]
    @redirect_url = params[:redirect_url]
    super
  end

  # POST /resource
  def create
    build_resource(sign_up_params)
    resource.save
    resource.reload 
    
    if params[:redirect_url]
      redirect_path = params[:redirect_url]
    else
      redirect_path = after_sign_in_path_for(resource)
    end

    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: redirect_path
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: redirect_path
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource, location: redirect_path
    end

    if params[:block_id]
      @block = Block.find(params[:block_id])
      @block.adopt current_user
      @block.save
    end

    if params[:neighborhood_id]
      @neighborhood = Neighborhood.find(params[:neighborhood_id])
      @neighborhood.add_follower current_user
    end

  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    super
  end

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

  # protected

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

  # The path used after sign up.
  def after_update_path_for(resource)
    user_path(resource)
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  def confirm_user_or_admin

  end
end
