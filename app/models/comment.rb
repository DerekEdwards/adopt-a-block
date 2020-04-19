class Comment < ApplicationRecord

  belongs_to :cleaning
  belongs_to :user

  def html_message #this method can be made obsolete by switching to auto_html
    self.message.gsub("\n", "<br>")
  end

end
