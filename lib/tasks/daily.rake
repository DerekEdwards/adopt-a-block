namespace :daily do
  
  desc "Check for block expirations"
  task :check_for_expirations => :environment do
    Block.all.each do |b|
      if b.adoption_expiration and b.adoption_expiration < Time.now
        b.unadopt
      end
    end
  end

  desc "Check for blocks that need to be cleaned"
  task :check_for_dirty_blocks => :environment do 
    User.all.each do |user|
      dirty_blocks = []
      user.blocks.each do |block|
        # Check to see if it's been exactly 10 days (This assumes that the task is only run once per day)
        if ((Time.now - block.last_cleaned)/(24*3600)).to_i == 10
          dirty_blocks << block
        end
      end
      unless dirty_blocks.empty?
        UserMailer.reminder_email(user, dirty_blocks).deliver!
      end
    end
  end

end