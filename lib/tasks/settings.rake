namespace :settings do
  desc <<-DESC
    Changes a setting
    USAGE: rake settings:set[foo,bar]
  DESC

  task :set , [:var, :value] => :environment do |t, args|
    Setting.send "#{args[:var]}=", args[:value]
  end
end
