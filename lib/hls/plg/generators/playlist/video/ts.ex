defmodule HLS.Plg.Generators.Playlist.Video.TS do
  @behaviour HLS.Plg.Behaviours.Generators.Operational

  @spec generate(number, integer) :: bitstring
  def generate(duration, sequence_number \\ 0) do
    args = playlist_args(duration, sequence_number)

    HLS.Plg.Generators.Playlist.Common.generate(args, opening(args), ending(args))
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

  @spec playlist_args(number, integer) :: HLS.Plg.Types.Common.t
  def playlist_args(duration, sequence_number \\ 0) do
    %HLS.Plg.Types.Common{duration: duration, segment_extension: ".ts", sequence_number: sequence_number}
  end
end