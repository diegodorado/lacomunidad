class Setting < RailsSettings::CachedSettings

  #these methods are wrapped in a proc due to settings cache
  # then, the proc is cached instead of the value

  def self.candidates_season
    Proc.new do
      Time.now.between?(self.candidates_starts_at,self.candidates_ends_at) rescue false
    end.call
  end
  def self.votes_season
    Proc.new do
      Time.now.between?(self.votes_starts_at,self.votes_ends_at) rescue false
    end.call
  end
  def self.votes_result_season
    Proc.new do
      #vote results are available for 2 weeks
      Time.now.between?(self.votes_ends_at,self.votes_ends_at+2.weeks) rescue false
    end.call
  end
end
