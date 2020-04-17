namespace :sample do
  
  desc "Add Sample Neighborhood"
  task :neighborhood => :environment do
    puts "Creating a Sample Neighborhood"
  end

  desc "Add Sample Data"
  task :all => :environment do 
    Rake::Task["sample:neighborhood"].invoke
  end

end