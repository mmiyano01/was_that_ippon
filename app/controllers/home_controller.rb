class HomeController < ApplicationController
	def index
		@video_info = VideoInfoRepository.new.find
	end
end