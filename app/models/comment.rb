class Comment < ApplicationRecord

  belongs_to :cleaning
  belongs_to :user

  # TODO: Replace this. It is currently used to redirect the user after creating/updating a comment
  attr_accessor :redirect_path

  def html_message #this method can be made obsolete by switching to auto_html
    self.message.gsub("\n", "<br>")
  end

end
