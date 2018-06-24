class VideoInfoRepository
  require 'json'
  def find
    file = File.read('lib/assets/video_info.json')
    
    response = JSON.parse(file)

    response["video_info"].inject([]) {|z, info|
      z << VideoInfoEntity.new(
        info["name"], 
        info["video_id"], 
        info["start_at"], 
        info["end_at"], 
        info["result"], 
        info["level"], 
        info["added_at"]
        ) if info.present?
      z    
    } 
  end  
end