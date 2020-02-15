defmodule HLS.PlgTest.Generators.Playlist.Subtitle.VTT do
  use ExUnit.Case
  doctest HLS.Plg.Generators.Playlist.Subtitle.VTT

  test "exact amount of segments in a duration" do
    result =
      """
      #EXTM3U
      #EXT-X-VERSION:3
      #EXT-X-MEDIA-SEQUENCE:0
      #EXT-X-ALLOW-CACHE:YES
      #EXT-X-TARGETDURATION:146
      #EXTINF:146.000000,
      segment_0001.vtt
      #EXT-X-ENDLIST
      """
    assert HLS.Plg.Generators.Playlist.Subtitle.VTT.generate(146, 0) == result
  end

  test "fractional number of segments in a duration" do
    result =
      """
      #EXTM3U
      #EXT-X-VERSION:3
      #EXT-X-MEDIA-SEQUENCE:0
      #EXT-X-ALLOW-CACHE:YES
      #EXT-X-TARGETDURATION:146
      #EXTINF:145.800000,
      segment_0001.vtt
      #EXT-X-ENDLIST
      """
    assert HLS.Plg.Generators.Playlist.Subtitle.VTT.generate(145.8, 0) == result
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
      segment_0001.vtt
      #EXT-X-ENDLIST
      """
    assert HLS.Plg.Generators.Playlist.Subtitle.VTT.generate(10, 2) == result
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
      subs/segment_0001.vtt
      #EXT-X-ENDLIST
      """
    assert HLS.Plg.Generators.Playlist.Subtitle.VTT.generate(10, 2, "subs/") == result
  end
end
