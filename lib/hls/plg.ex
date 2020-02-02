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
  def generate_ts_playlist(duration, sequence_number \\ 0) do
    HLS.Plg.Generators.Playlist.Video.TS.generate(duration, sequence_number)
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
  def generate_aac_playlist(duration, sequence_number \\ 0) do
    HLS.Plg.Generators.Playlist.Audio.AAC.generate(duration, sequence_number)
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
  def generate_vtt_playlist(duration, sequence_number \\ 0) do
    HLS.Plg.Generators.Playlist.Subtitle.VTT.generate(duration, sequence_number)
  end
end
