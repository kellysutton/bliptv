require 'lib/bliptv'

class TC_BaseTest < Test::Unit::TestCase
  def setup
    @base = BlipTV::Base.new
  end

  def teardown
  end

  def test_find_all_videos_by_user

    videos = @base.find_all_videos_by_user("onemonthhere")

    assert_not_equal nil, videos
    assert_instance_of Array, videos
    assert videos.size >= 12 # at the time of the writing of the test

    videos.each do |video|
      assert_not_equal "", video.title # all videos must have a title
      assert_equal "onemonthhere", video.author
      assert_equal "false", video.explicit # I know for a fact that all videos are not explicit
    end
  end

  def test_find_all_videos_by_user_retrieve_100

    videos = @base.find_all_videos_by_user("verycocinar", {:page => 1, :pagelen => 100})

    assert_not_equal nil, videos
    assert_instance_of Array, videos
    assert videos.size == 100
  end

  def test_find_all_videos_by_user_more_than_one_page

    videos_1 = @base.find_all_videos_by_user("verycocinar", {:page => 2, :pagelen => 30})
    videos_2 = @base.find_all_videos_by_user("verycocinar", {:page => 3, :pagelen => 30})

    assert_instance_of Array, videos_1
    assert_instance_of Array, videos_2
    assert videos_1.size == 30
    assert videos_2.size == 30
    assert_not_equal videos_1, videos_2
  end

  def test_search_videos
    videos = @base.search_videos("cool")

    assert_not_equal nil, videos # unless Blip.tv is having a bad day :(
    assert_instance_of Array, videos
    assert videos.size > 10 # assumption

    videos.each do |video|
      assert_not_equal "", video.title # all videos must have a title
    end
  end
end