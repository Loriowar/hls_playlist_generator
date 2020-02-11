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

  test "generate_master_playlist works as expected" do
    result =
      """
      #EXTM3U

      #EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="audio",LANGUAGE="en",NAME="English",DEFAULT=YES,AUTOSELECT=YES,URI="playlist.m3u8"

      #EXT-X-MEDIA:TYPE=SUBTITLES,GROUP-ID="subs",LANGUAGE="en",NAME="English",DEFAULT=NO,AUTOSELECT=YES,FORCED=NO,URI="playlist.m3u8"

      #EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=510000,AUDIO="audio",SUBTITLES="subs",RESOLUTION=640x480
      playlist.m3u8
      """

    assert HLS.Plg.generate_master_playlist(42) == result
  end
end
