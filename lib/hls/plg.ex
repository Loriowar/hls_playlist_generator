defmodule HLS.Plg do
  @moduledoc """
  Documentation for HLS.Plg - HLS Playlist Generator.
  """

  @doc """
  Generate a playlist with MPEG-2 Transport Stream format of segments

  ## Examples

      ```elixir
      > HLS.Plg.generate_ts_playlist(42, 1) |> IO.puts
      #EXTM3U
      #EXT-X-VERSION:3
      #EXT-X-MEDIA-SEQUENCE:1
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
      #EXTINF:2.000000,
      segment_0005.ts
      #EXT-X-ENDLIST
      ```

  """
  def generate_ts_playlist(duration, sequence_number \\ 0, segment_path \\ "") do
    HLS.Plg.Generators.Playlist.Video.TS.generate(duration, sequence_number, segment_path)
  end

  @doc """
  Generate a playlist with Advanced Audio Coding format of segments

  ## Examples

      ```elixir
      > HLS.Plg.generate_aac_playlist(42, 1) |> IO.puts
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
      #EXTINF:10.000000,
      segment_0004.aac
      #EXTINF:2.000000,
      segment_0005.aac
      #EXT-X-ENDLIST
      ```

  """
  def generate_aac_playlist(duration, sequence_number \\ 0, segment_path \\ "") do
    HLS.Plg.Generators.Playlist.Audio.AAC.generate(duration, sequence_number, segment_path)
  end

  @doc """
  Generate a playlist with Web Video Text Tracks format of segments

  ## Examples

      ```elixir
      > HLS.Plg.generate_aac_playlist(42, 42) |> IO.puts
      #EXTM3U
      #EXT-X-VERSION:3
      #EXT-X-MEDIA-SEQUENCE:1
      #EXT-X-ALLOW-CACHE:YES
      #EXT-X-TARGETDURATION:42
      #EXTINF:42.000000,
      segment_0001.vtt
      #EXT-X-ENDLIST
      ```

  """
  def generate_vtt_playlist(duration, sequence_number \\ 0, segment_path \\ "") do
    HLS.Plg.Generators.Playlist.Subtitle.VTT.generate(duration, sequence_number, segment_path)
  end

  @doc """
    Generate a master playlist for HLS format

    ## Examples

      ```elixir
      > HLS.Plg.generate_master_playlist(42) |> IO.puts
      #EXTM3U

      #EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="audio",LANGUAGE="en",NAME="English",DEFAULT=YES,AUTOSELECT=YES,URI="playlist.m3u8"

      #EXT-X-MEDIA:TYPE=SUBTITLES,GROUP-ID="subs",LANGUAGE="en",NAME="English",DEFAULT=NO,AUTOSELECT=YES,FORCED=NO,URI="playlist.m3u8"

      #EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=510000,AUDIO="audio",SUBTITLES="subs",RESOLUTION=640x480
      playlist.m3u8
      ```

  """
  def generate_master_playlist(_args) do
    HLS.Plg.Generators.Playlist.Master.generate(%HLS.Plg.Types.Master{audio: [%HLS.Plg.Types.MasterRow{}], subtitles: [%HLS.Plg.Types.MasterRow{}], video: [%HLS.Plg.Types.MasterRow{}]})
  end

  @doc """
    Generate all playlists for HLS format
  """
  def generate_all(args) do
    HLS.Plg.Generators.Playlist.All.generate(args)
  end
end
