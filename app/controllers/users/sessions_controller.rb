# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    @block_id = params[:block_id]
    @neighborhood_id = params[:neighborhood_id]
    super
  end

  # POST /resource/sign_in
  def create
    super
   
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
