namespace :daily do
  
  desc "Check for block expirations"
  task :check_for_expirations => :environment do
    Block.all.each do |b|
      if b.adoption_expiration and b.adoption_expiration < Time.now
        b.unadopt true
      end
    end
  end

  desc "Check for blocks that need to be cleaned"
  task :check_for_dirty_blocks => :environment do 
    User.all.each do |user|
      dirty_blocks = []
      user.blocks.each do |block|
        # Check to see if it's been exactly 10 days (This assumes that the task is only run once per day)
        relevant_days = block.last_cleaned.nil? ? ((Time.now - block.created_at)/(24*3600)).to_i : ((Time.now - block.last_cleaned)/(24*3600)).to_i
        if relevant_days % 10 == 0 and relevant_days > 0
          dirty_blocks << block 
        end
      end
      unless dirty_blocks.empty?
        UserMailer.reminder_email(user, dirty_blocks).deliver!
      end
    end
  end

  desc "Run all daily tasks"
  task :all => :environment do 
    Rake::Task["daily:check_for_expirations"].invoke
    Rake::Task["daily:check_for_dirty_blocks"].invoke
  end

end