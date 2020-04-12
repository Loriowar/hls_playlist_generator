defmodule HLS.PlgTest.Generators.Playlist.Master do
  use ExUnit.Case
  doctest HLS.Plg.Generators.Playlist.Master

  test "proper amount of rows" do
    result =
      """
      #EXTM3U

      #EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="audio",LANGUAGE="ru",NAME="Russian",DEFAULT=YES,AUTOSELECT=YES,CHANNELS="2",URI="audio/rus/playlist.m3u8"

      #EXT-X-MEDIA:TYPE=SUBTITLES,GROUP-ID="subs",LANGUAGE="en",NAME="English",DEFAULT=NO,AUTOSELECT=YES,FORCED=YES,URI="subs/en/playlist.m3u8"

      #EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1725000,AUDIO="audio",SUBTITLES="subs",RESOLUTION=1280x720
      video/pl.m3u8
      """
      args =
        %HLS.Plg.Types.Master{
          audio: [%HLS.Plg.Types.MasterRow{language: "ru", name: "Russian", playlist_path: "audio/rus/"}],
          subtitles: [%HLS.Plg.Types.MasterRow{language: "en", name: "English", forced: true, playlist_path: "subs/en/"}],
          video: [%HLS.Plg.Types.MasterRow{bandwidth: 1725000, resolution: "1280x720", playlist_path: "video/", playlist_name: "pl.m3u8"}]
        }

    assert HLS.Plg.Generators.Playlist.Master.generate(args) == result
  end

  test "multiple items in each playlist section" do
    result =
      """
      #EXTM3U

      #EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="audio",LANGUAGE="ru",NAME="Russian",DEFAULT=YES,AUTOSELECT=YES,CHANNELS="2",URI="audio/rus/playlist.m3u8"
      #EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="audio",LANGUAGE="de",NAME="Deutsche",DEFAULT=NO,AUTOSELECT=YES,CHANNELS="2",URI="audio/de/playlist.m3u8"

      #EXT-X-MEDIA:TYPE=SUBTITLES,GROUP-ID="subs",LANGUAGE="en",NAME="English",DEFAULT=NO,AUTOSELECT=YES,FORCED=YES,URI="subs/en/playlist.m3u8"
      #EXT-X-MEDIA:TYPE=SUBTITLES,GROUP-ID="subs",LANGUAGE="de",NAME="Deutsche",DEFAULT=NO,AUTOSELECT=YES,FORCED=NO,URI="subs/de/playlist.m3u8"

      #EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1725000,AUDIO="audio",SUBTITLES="subs",RESOLUTION=1280x720
      video/720p/playlist.m3u8
      #EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=3400000,AUDIO="audio",SUBTITLES="subs",RESOLUTION=1920x1080
      video/1080p/playlist.m3u8
      """
    args =
      %HLS.Plg.Types.Master{
        audio: [
          %HLS.Plg.Types.MasterRow{language: "ru", name: "Russian", playlist_path: "audio/rus/"},
          %HLS.Plg.Types.MasterRow{language: "de", name: "Deutsche", playlist_path: "audio/de/"}
        ],
        subtitles: [
          %HLS.Plg.Types.MasterRow{language: "en", name: "English", forced: true, playlist_path: "subs/en/"},
          %HLS.Plg.Types.MasterRow{language: "de", name: "Deutsche", playlist_path: "subs/de/"}
        ],
        video: [
          %HLS.Plg.Types.MasterRow{bandwidth: 1725000, resolution: "1280x720", playlist_path: "video/720p/"},
          %HLS.Plg.Types.MasterRow{bandwidth: 3400000, resolution: "1920x1080", playlist_path: "video/1080p/"}
        ]
      }

    assert HLS.Plg.Generators.Playlist.Master.generate(args) == result
  end
end
