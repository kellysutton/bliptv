require 'lib/bliptv'

class TC_BaseTest < Test::Unit::TestCase
  def setup
  end
  
  def teardown
  end
  
  def test_find_all_videos_by_user
    base = BlipTV::Base.new
    
    videos = base.find_all_videos_by_user("onemonthhere")
    
    assert_not_equal nil, videos
    assert videos.size >= 12 # at the time of the writing of the test
    
    videos.each do |video|
      assert_equal "onemonthhere", video.author
      assert_equal "false", video.explicit # I know for a fact that all videos are not explicit
    end
  end
end