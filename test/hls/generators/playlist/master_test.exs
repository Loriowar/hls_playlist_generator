defmodule HLS.PlgTest.Generators.Playlist.Master do
  use ExUnit.Case
  doctest HLS.Plg.Generators.Playlist.Master

  test "proper amount of rows" do
    result =
      """
      #EXTM3U

      #EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="audio",LANGUAGE="ru",NAME="Russian",DEFAULT=YES,AUTOSELECT=YES,URI="audio/rus/playlist.m3u8"

      #EXT-X-MEDIA:TYPE=SUBTITLES,GROUP-ID="subs",LANGUAGE="en",NAME="English",DEFAULT=NO,AUTOSELECT=YES,FORCED=YES,URI="subs/en/playlist.m3u8"

      #EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1725000,AUDIO="audio",SUBTITLES="subs",RESOLUTION=1280x720
      video/playlist.m3u8
      """
      args =
        %HLS.Plg.Types.Master{
          audio: [%HLS.Plg.Types.MasterRow{language: "ru", name: "Russian", path: "audio/rus/playlist.m3u8"}],
          subtitles: [%HLS.Plg.Types.MasterRow{language: "en", name: "English", forced: true, path: "subs/en/playlist.m3u8"}],
          video: [%HLS.Plg.Types.MasterRow{bandwidth: 1725000, resolution: "1280x720", path: "video/playlist.m3u8"}]
        }

    assert HLS.Plg.Generators.Playlist.Master.generate(args) == result
  end

  test "multiple items in each playlist section" do
    result =
      """
      #EXTM3U

      #EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="audio",LANGUAGE="ru",NAME="Russian",DEFAULT=YES,AUTOSELECT=YES,URI="audio/rus/playlist.m3u8"
      #EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="audio",LANGUAGE="de",NAME="Deutsche",DEFAULT=NO,AUTOSELECT=YES,URI="audio/de/playlist.m3u8"

      #EXT-X-MEDIA:TYPE=SUBTITLES,GROUP-ID="subs",LANGUAGE="en",NAME="English",DEFAULT=NO,AUTOSELECT=YES,FORCED=YES,URI="subs/en/playlist.m3u8"
      #EXT-X-MEDIA:TYPE=SUBTITLES,GROUP-ID="subs",LANGUAGE="ge",NAME="Deutsche",DEFAULT=NO,AUTOSELECT=YES,FORCED=NO,URI="subs/de/playlist.m3u8"

      #EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1725000,AUDIO="audio",SUBTITLES="subs",RESOLUTION=1280x720
      video/720p/playlist.m3u8
      #EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=3400000,AUDIO="audio",SUBTITLES="subs",RESOLUTION=1920x1080
      video/1080p/playlist.m3u8
      """
    args =
      %HLS.Plg.Types.Master{
        audio: [
          %HLS.Plg.Types.MasterRow{language: "ru", name: "Russian", path: "audio/rus/playlist.m3u8"},
          %HLS.Plg.Types.MasterRow{language: "de", name: "Deutsche", path: "audio/de/playlist.m3u8"}
        ],
        subtitles: [
          %HLS.Plg.Types.MasterRow{language: "en", name: "English", forced: true, path: "subs/en/playlist.m3u8"},
          %HLS.Plg.Types.MasterRow{language: "ge", name: "Deutsche", path: "subs/de/playlist.m3u8"}
        ],
        video: [
          %HLS.Plg.Types.MasterRow{bandwidth: 1725000, resolution: "1280x720", path: "video/720p/playlist.m3u8"},
          %HLS.Plg.Types.MasterRow{bandwidth: 3400000, resolution: "1920x1080", path: "video/1080p/playlist.m3u8"}
        ]
      }

    assert HLS.Plg.Generators.Playlist.Master.generate(args) == result
  end
end
