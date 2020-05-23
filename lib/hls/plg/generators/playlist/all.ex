defmodule HLS.Plg.Generators.Playlist.All do
  @spec generate(HLS.Plg.Types.Master.t) :: HLS.Plg.Types.All.t
  def generate(args) do
    %HLS.Plg.Types.All{
      master: generate_mater(args),
      common: %HLS.Plg.Types.CommonContainer{
        audio: generate_audio(args),
        subtitles: generate_subtitles(args),
        video: generate_video(args)
      }
    }
  end

  defp generate_mater(args) do
    HLS.Plg.Generators.Playlist.Master.generate(args)
  end

  defp generate_audio(args) do
    args.audio
    |> Enum.reduce(%{}, fn(pl, result) ->
      Map.merge(result, %{pl.playlist_path => pl.details |> HLS.Plg.Generators.Playlist.Audio.AAC.generate})
    end)
  end

  defp generate_subtitles(args) do
    args.subtitles
    |> Enum.reduce(%{}, fn(pl, result) ->
      Map.merge(result, %{pl.playlist_path => pl.details |> HLS.Plg.Generators.Playlist.Subtitle.VTT.generate})
    end)
  end

  defp generate_video(args) do
    args.video
    |> Enum.reduce(%{}, fn(pl, result) ->
      Map.merge(result, %{pl.playlist_path => pl.details |> HLS.Plg.Generators.Playlist.Video.TS.generate})
    end)
  end
end
