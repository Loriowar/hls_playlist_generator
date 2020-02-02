defmodule HLS.PlgTest.Generators.Playlist.Video.TS do
  use ExUnit.Case
  doctest HLS.Plg.Generators.Playlist.Video.TS

  test "exact amount of segments in a duration" do
    result =
      """
      #EXTM3U
      #EXT-X-VERSION:3
      #EXT-X-MEDIA-SEQUENCE:0
      #EXT-X-ALLOW-CACHE:YES
      #EXT-X-TARGETDURATION:10
      #EXTINF:10.000000,
      segment_0001.ts
      #EXTINF:10.000000,
      segment_0002.ts
      #EXTINF:10.000000,
      segment_0003.ts
      #EXTINF:10.000000,
      segment_0004.ts
      #EXT-X-ENDLIST
      """
    assert HLS.Plg.Generators.Playlist.Video.TS.generate(40) == result
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
      segment_0001.ts
      #EXTINF:10.000000,
      segment_0002.ts
      #EXTINF:10.000000,
      segment_0003.ts
      #EXTINF:10.000000,
      segment_0004.ts
      #EXTINF:2.200000,
      segment_0005.ts
      #EXT-X-ENDLIST
      """
    assert HLS.Plg.Generators.Playlist.Video.TS.generate(42.2) == result
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
      segment_0001.ts
      #EXT-X-ENDLIST
      """
    assert HLS.Plg.Generators.Playlist.Video.TS.generate(10, 2) == result
  end
end
