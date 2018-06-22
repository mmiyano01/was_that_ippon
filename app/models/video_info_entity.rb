class VideoInfoEntity 
  attr_reader :name, :url, :start_at, :end_at, :result, :level, :added_at
  
  def initialize(name, url, start_at, end_at, result, level, added_at)
    @name = name
    @url = url
    @start_at = start_at
    @end_at = end_at
    @result = result
    @level = level
    @added_at = added_at
  end
end