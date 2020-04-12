defmodule HLS.PlgTest.Generators.Playlist.All do
  use ExUnit.Case
  doctest HLS.Plg.Generators.Playlist.All

  test "proper amount of rows" do
    result =
      %{
        common: %{
          audio: %{
            "audio/rus/" => "#EXTM3U\n#EXT-X-VERSION:3\n#EXT-X-MEDIA-SEQUENCE:0\n#EXT-X-ALLOW-CACHE:YES\n#EXT-X-TARGETDURATION:10\n#EXTINF:3.200000,\nsegment_0001.aac\n#EXT-X-ENDLIST\n"
          },
          subtitles: %{
            "subs/en/" => "#EXTM3U\n#EXT-X-VERSION:3\n#EXT-X-MEDIA-SEQUENCE:1\n#EXT-X-ALLOW-CACHE:YES\n#EXT-X-TARGETDURATION:10\n#EXTINF:3.000000,\nsegment_0001.vtt\n#EXT-X-ENDLIST\n"
          },
          video: %{
            "video/" => "#EXTM3U\n#EXT-X-VERSION:3\n#EXT-X-MEDIA-SEQUENCE:2\n#EXT-X-ALLOW-CACHE:YES\n#EXT-X-TARGETDURATION:10\n#EXTINF:3.140000,\nsegment_0001.ts\n#EXT-X-ENDLIST\n"
          }
        },
        master:
          """
          #EXTM3U

          #EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="audio",LANGUAGE="ru",NAME="Russian",DEFAULT=YES,AUTOSELECT=YES,CHANNELS="4",URI="audio/rus/playlist.m3u8"

          #EXT-X-MEDIA:TYPE=SUBTITLES,GROUP-ID="subs",LANGUAGE="en",NAME="English",DEFAULT=NO,AUTOSELECT=YES,FORCED=YES,URI="subs/en/playlist.m3u8"

          #EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1725000,AUDIO="audio",SUBTITLES="subs",RESOLUTION=1280x720
          video/pl.m3u8
          """
      }

      args =
        %HLS.Plg.Types.Master{
          audio: [
            %HLS.Plg.Types.MasterRow{
              language: "ru",
              name: "Russian",
              channels: 4,
              playlist_path: "audio/rus/",
              details: %HLS.Plg.Types.Common{duration: 3.2, sequence_number: 0}
            }
          ],
          subtitles: [
            %HLS.Plg.Types.MasterRow{
              language: "en",
              name: "English",
              forced: true,
              playlist_path: "subs/en/",
              details: %HLS.Plg.Types.Common{duration: 3, sequence_number: 1}
            }
          ],
          video: [
            %HLS.Plg.Types.MasterRow{
              bandwidth: 1725000,
              resolution: "1280x720",
              playlist_path: "video/",
              playlist_name: "pl.m3u8",
              details: %HLS.Plg.Types.Common{duration: 3.14, sequence_number: 2}
            }
          ]
        }

    assert HLS.Plg.Generators.Playlist.All.generate(args) == result
  end

  test "multiple items in each playlist section" do
    result =
      %{
        common: %{
          audio: %{
            "audio/de/" =>
              """
              #EXTM3U
              #EXT-X-VERSION:3
              #EXT-X-MEDIA-SEQUENCE:1
              #EXT-X-ALLOW-CACHE:YES
              #EXT-X-TARGETDURATION:10
              #EXTINF:10.000000,
              segment_0001.aac
              #EXTINF:10.000000,
              segment_0002.aac
              #EXTINF:10.000000,
              segment_0003.aac
              #EXTINF:3.200000,
              segment_0004.aac
              #EXT-X-ENDLIST
              """,
            "audio/rus/" =>
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
              #EXTINF:3.100000,
              segment_0004.aac
              #EXT-X-ENDLIST
              """,
          },
          subtitles: %{
            "subs/de/" =>
              """
              #EXTM3U
              #EXT-X-VERSION:3
              #EXT-X-MEDIA-SEQUENCE:3
              #EXT-X-ALLOW-CACHE:YES
              #EXT-X-TARGETDURATION:10
              #EXTINF:31.000000,
              segment_0001.vtt
              #EXT-X-ENDLIST
              """,
            "subs/en/" =>
              """
              #EXTM3U
              #EXT-X-VERSION:3
              #EXT-X-MEDIA-SEQUENCE:2
              #EXT-X-ALLOW-CACHE:YES
              #EXT-X-TARGETDURATION:10
              #EXTINF:32.000000,
              segment_0001.vtt
              #EXT-X-ENDLIST
              """
          },
          video: %{
            "video/1080p/" =>
              """
              #EXTM3U
              #EXT-X-VERSION:3
              #EXT-X-MEDIA-SEQUENCE:5
              #EXT-X-ALLOW-CACHE:YES
              #EXT-X-TARGETDURATION:10
              #EXTINF:10.000000,
              segment_0001.ts
              #EXTINF:10.000000,
              segment_0002.ts
              #EXTINF:10.000000,
              segment_0003.ts
              #EXTINF:4.100000,
              segment_0004.ts
              #EXT-X-ENDLIST
              """,
            "video/720p/" =>
              """
              #EXTM3U
              #EXT-X-VERSION:3
              #EXT-X-MEDIA-SEQUENCE:4
              #EXT-X-ALLOW-CACHE:YES
              #EXT-X-TARGETDURATION:10
              #EXTINF:10.000000,
              segment_0001.ts
              #EXTINF:10.000000,
              segment_0002.ts
              #EXTINF:10.000000,
              segment_0003.ts
              #EXTINF:4.000000,
              segment_0004.ts
              #EXT-X-ENDLIST
              """
          }
        },
        master:
          """
          #EXTM3U

          #EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="audio",LANGUAGE="ru",NAME="Russian",DEFAULT=YES,AUTOSELECT=YES,CHANNELS="4",URI="audio/rus/playlist.m3u8"
          #EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="audio",LANGUAGE="de",NAME="Deutsche",DEFAULT=NO,AUTOSELECT=YES,CHANNELS="4",URI="audio/de/playlist.m3u8"

          #EXT-X-MEDIA:TYPE=SUBTITLES,GROUP-ID="subs",LANGUAGE="en",NAME="English",DEFAULT=NO,AUTOSELECT=YES,FORCED=YES,URI="subs/en/playlist.m3u8"
          #EXT-X-MEDIA:TYPE=SUBTITLES,GROUP-ID="subs",LANGUAGE="de",NAME="Deutsche",DEFAULT=NO,AUTOSELECT=YES,FORCED=NO,URI="subs/de/playlist.m3u8"

          #EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1725000,AUDIO="audio",SUBTITLES="subs",RESOLUTION=1280x720
          video/720p/playlist.m3u8
          #EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=3400000,AUDIO="audio",SUBTITLES="subs",RESOLUTION=1920x1080
          video/1080p/playlist.m3u8
          """
      }

    args =
      %HLS.Plg.Types.Master{
        audio: [
          %HLS.Plg.Types.MasterRow{
            language: "ru",
            name: "Russian",
            channels: 4,
            playlist_path: "audio/rus/",
            details: %HLS.Plg.Types.Common{duration: 33.1, sequence_number: 0}
          },
          %HLS.Plg.Types.MasterRow{
            language: "de",
            name: "Deutsche",
            channels: 4,
            playlist_path: "audio/de/",
            details: %HLS.Plg.Types.Common{duration: 33.2, sequence_number: 1}
          }
        ],
        subtitles: [
          %HLS.Plg.Types.MasterRow{
            language: "en",
            name: "English",
            forced: true,
            playlist_path: "subs/en/",
            details: %HLS.Plg.Types.Common{duration: 32, sequence_number: 2}
          },
          %HLS.Plg.Types.MasterRow{
            language: "de",
            name: "Deutsche",
            playlist_path: "subs/de/",
            details: %HLS.Plg.Types.Common{duration: 31, sequence_number: 3}
          }
        ],
        video: [
          %HLS.Plg.Types.MasterRow{
            bandwidth: 1725000,
            resolution: "1280x720",
            playlist_path: "video/720p/",
            details: %HLS.Plg.Types.Common{duration: 34, sequence_number: 4}
          },
          %HLS.Plg.Types.MasterRow{
            bandwidth: 3400000,
            resolution: "1920x1080",
            playlist_path: "video/1080p/",
            details: %HLS.Plg.Types.Common{duration: 34.1, sequence_number: 5}
          }
        ]
      }

    assert HLS.Plg.Generators.Playlist.All.generate(args) == result
  end
end
