class Admin::CleaningsController < ApplicationController

  def create
    @cleaning = Cleaning.new
    @cleaning.update_attributes!(cleaning_params)
    @cleaning.time = Time.now
    @cleaning.save!
    redirect_to admin_block_path @cleaning.block
  end 

  private

  def cleaning_params
    params.require(:cleaning).permit(:note, :block_id, :before_photo, :after_photo)
  end

end