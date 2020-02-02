defmodule HLS.Plg.Generators.Playlist.Common do
  @behaviour HLS.Plg.Behaviours.Generators.Common

  @spec generate(HLS.Plg.Types.Common.t, String.t, String.t) :: bitstring
  def generate(args, opening, ending) when is_bitstring(opening) and is_bitstring(ending) do
    playlist(args, opening, ending)
  end

  defp playlist(args, opening, ending) do
    "#{opening}#{segments_body(args)}#{ending}\n"
  end

  defp segments_body(args) do
    "#{segments_main_body(args)}#{last_segment(args)}"
  end

  defp segments_main_body(args) do
    amount_segments = (args.duration / args.target_duration) |> trunc

    if amount_segments == 0 do
      ""
    else
      common_prefix = segment_prefix(args.target_duration)

      Enum.reduce(1..amount_segments, "", fn n, pl ->
        "#{pl}#{common_prefix}\n#{segment_name(n, args)}\n"
      end)
    end
  end

  defp last_segment(args) do
    amount_segments = (args.duration / args.target_duration) |> trunc
    last_segment_duration = (args.duration - amount_segments * args.target_duration)

    if last_segment_duration > 0 do
      last_segment_prefix = last_segment_duration |> segment_prefix
      last_segment_name = segment_name(amount_segments + 1, args)

      "#{last_segment_prefix}\n#{last_segment_name}\n"
    else
      ""
    end
  end

  # input: 10.2, output: "#EXTINF:10.200000,"
  defp segment_prefix(duration) when is_number(duration) do
    segment_prefix_opening = "#EXTINF:"
    segment_prefix_ending = ","
    "#{segment_prefix_opening}#{duration |> to_duration_format}#{segment_prefix_ending}"
  end

  # input: 42, output: "segment_0042.ts"
  defp segment_name(segment_number, args) when is_integer(segment_number) do
    "#{args.segment_basename}#{segment_number |> to_segment_number_format(args.segment_number_length)}#{args.segment_extension}"
  end

  # input: 10.2, output: "10.200000"
  defp to_duration_format(duration) when is_number(duration) do
    # division is for typecast into a float
    duration / 1 |> :erlang.float_to_binary([decimals: 6])
  end

  # input: 42, output: "0042"
  defp to_segment_number_format(segment_number, length) when is_integer(segment_number) and is_integer(length) do
    segment_number |> Integer.to_string |> String.pad_leading(length, "0")
  end
end
