# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    @block_id = params[:block_id]
    @neighborhood_id = params[:neighborhood_id]
    @redirect_url = params[:redirect_url]
    super
  end

  # POST /resource/sign_in
  def create
    ##############
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?

    if params[:redirect_url]
      redirect_path = params[:redirect_url]
    else
      redirect_path = after_sign_in_path_for(resource)
    end

    respond_with resource, location: redirect_path #after_sign_in_path_for(resource)
    ##############
   
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

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
