class Admin::CleaningsController < ApplicationController

  before_action :set_cleaning, except: [:create]
  before_action :confirm_editable, only: [:update]

  def create
    @cleaning = Cleaning.new
    @cleaning.update_attributes!(cleaning_params)
    @cleaning.save!
    redirect_to admin_block_path @cleaning.block
  end 

  def edit
    @block = @cleaning.block
  end

  def update
    @cleaning.update_attributes!(cleaning_params)
    @cleaning.save!
    redirect_to admin_block_path @cleaning.block
  end

  def destroy
    @cleaning.destroy 
    redirect_to admin_block_path @cleaning.block
  end

  private

  def set_cleaning
    @cleaning = Cleaning.find(params[:id])
  end

  def cleaning_params
    params.require(:cleaning).permit(:note, :time, :block_id, :before_photo, :after_photo)
  end

  def confirm_editable
    unless @cleaning.editable?
      head(403)
    end
  end

end