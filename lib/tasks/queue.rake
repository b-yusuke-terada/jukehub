namespace :queue do
  desc "Queue Watch"
  task :watch => :environment do
    Room.all.each do |room|
      ::Service::WatchQueue.new({room: room}).execute
    end
  end
end
