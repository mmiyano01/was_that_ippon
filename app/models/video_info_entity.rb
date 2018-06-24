class VideoInfoEntity 
  attr_reader :name, :video_id, :start_at, :end_at, :result, :level, :added_at
  
  def initialize(name, video_id, start_at, end_at, result, level, added_at)
    @name = name
    @video_id = video_id
    @start_at = start_at
    @end_at = end_at
    @result = result
    @level = level
    @added_at = added_at
  end
end