defmodule HLS.PlgTest do
  use ExUnit.Case
  doctest HLS.Plg

  test "generate_ts_playlist works as expected" do
    result =
      """
      #EXTM3U
      #EXT-X-VERSION:3
      #EXT-X-MEDIA-SEQUENCE:0
      #EXT-X-ALLOW-CACHE:YES
      #EXT-X-TARGETDURATION:10
      #EXTINF:1.000000,
      segment_0001.ts
      #EXT-X-ENDLIST
      """

    assert HLS.Plg.generate_ts_playlist(1) == result
  end

  test "generate_aac_playlist works as expected" do
    result =
      """
      #EXTM3U
      #EXT-X-VERSION:3
      #EXT-X-MEDIA-SEQUENCE:0
      #EXT-X-ALLOW-CACHE:YES
      #EXT-X-TARGETDURATION:10
      #EXTINF:1.000000,
      segment_0001.aac
      #EXT-X-ENDLIST
      """

    assert HLS.Plg.generate_aac_playlist(1) == result
  end

  test "generate_vtt_playlist works as expected" do
    result =
      """
      #EXTM3U
      #EXT-X-VERSION:3
      #EXT-X-MEDIA-SEQUENCE:0
      #EXT-X-ALLOW-CACHE:YES
      #EXT-X-TARGETDURATION:2
      #EXTINF:1.200000,
      segment_0001.vtt
      #EXT-X-ENDLIST
      """

    assert HLS.Plg.generate_vtt_playlist(1.2) == result
  end
end
