namespace :daily do
  
  desc "Check for block expirations"
  task :check_for_expirations => :environment do
    Block.all.each do |b|
      if b.adoption_expiration and b.adoption_expiration < Time.now
        b.unadopt
      end
    end
  end

end