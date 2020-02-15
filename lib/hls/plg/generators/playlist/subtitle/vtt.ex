defmodule HLS.Plg.Generators.Playlist.Subtitle.VTT do
  @behaviour HLS.Plg.Behaviours.Generators.Operational

  @spec generate(number, integer, bitstring) :: bitstring
  def generate(duration, sequence_number, segment_path \\ "")
      when is_number(duration) and is_integer(sequence_number) and is_bitstring(segment_path) do
    args = playlist_args(duration, sequence_number, segment_path)

    generate(args)
  end

  @spec generate(args :: HLS.Plg.Types.Common.t) :: bitstring
  def generate(args) do
    HLS.Plg.Generators.Playlist.Common.generate(prepare_args(args), opening(args), ending(args))
  end

  @spec opening(HLS.Plg.Types.Common.t) :: bitstring
  def opening(args) do
    """
    #EXTM3U
    #EXT-X-VERSION:3
    #EXT-X-MEDIA-SEQUENCE:#{args.sequence_number}
    #EXT-X-ALLOW-CACHE:YES
    #EXT-X-TARGETDURATION:#{args.target_duration}
    """
  end

  @spec ending(HLS.Plg.Types.Common.t) :: bitstring
  def ending(_args) do
    "#EXT-X-ENDLIST"
  end

  @spec playlist_args(number, integer, bitstring) :: HLS.Plg.Types.Common.t
  def playlist_args(duration, sequence_number \\ 0, segment_path \\ "") do
    %HLS.Plg.Types.Common{
      duration: duration,
      target_duration: target_duration(duration),
      sequence_number: sequence_number,
      segment_path: segment_path,
      segment_extension: ".vtt"
    }
  end

  defp prepare_args(args) do
    %{args | segment_extension: ".vtt", target_duration: target_duration(args.duration)}
  end

  defp target_duration(duration) when is_number(duration) do
    duration / 1 |> Float.ceil |> trunc
  end
end
