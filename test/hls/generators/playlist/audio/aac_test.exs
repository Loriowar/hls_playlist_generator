defmodule HLS.PlgTest.Generators.Playlist.Audio.AAC do
  use ExUnit.Case
  doctest HLS.Plg.Generators.Playlist.Audio.AAC

  test "exact amount of segments in a duration" do
    result =
      """
      #EXTM3U
      #EXT-X-VERSION:3
      #EXT-X-MEDIA-SEQUENCE:0
      #EXT-X-ALLOW-CACHE:YES
      #EXT-X-TARGETDURATION:10
      #EXTINF:10.000000,
      segment_0001.aac
      #EXTINF:10.000000,
      segment_0002.aac
      #EXTINF:10.000000,
      segment_0003.aac
      #EXTINF:10.000000,
      segment_0004.aac
      #EXT-X-ENDLIST
      """
    assert HLS.Plg.Generators.Playlist.Audio.AAC.generate(40) == result
  end

  test "fractional number of segments in a duration" do
    result =
      """
      #EXTM3U
      #EXT-X-VERSION:3
      #EXT-X-MEDIA-SEQUENCE:0
      #EXT-X-ALLOW-CACHE:YES
      #EXT-X-TARGETDURATION:10
      #EXTINF:10.000000,
      segment_0001.aac
      #EXTINF:10.000000,
      segment_0002.aac
      #EXTINF:10.000000,
      segment_0003.aac
      #EXTINF:10.000000,
      segment_0004.aac
      #EXTINF:2.200000,
      segment_0005.aac
      #EXT-X-ENDLIST
      """
    assert HLS.Plg.Generators.Playlist.Audio.AAC.generate(42.2) == result
  end

  test "proper media sequence based on input args" do
    result =
      """
      #EXTM3U
      #EXT-X-VERSION:3
      #EXT-X-MEDIA-SEQUENCE:2
      #EXT-X-ALLOW-CACHE:YES
      #EXT-X-TARGETDURATION:10
      #EXTINF:10.000000,
      segment_0001.aac
      #EXT-X-ENDLIST
      """
    assert HLS.Plg.Generators.Playlist.Audio.AAC.generate(10, 2) == result
  end

  test "proper path to sequence based on input args" do
    result =
      """
      #EXTM3U
      #EXT-X-VERSION:3
      #EXT-X-MEDIA-SEQUENCE:2
      #EXT-X-ALLOW-CACHE:YES
      #EXT-X-TARGETDURATION:10
      #EXTINF:10.000000,
      audio/segment_0001.aac
      #EXT-X-ENDLIST
      """
    assert HLS.Plg.Generators.Playlist.Audio.AAC.generate(10, 2, "audio/") == result
  end
end
