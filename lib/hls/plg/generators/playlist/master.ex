defmodule HLS.Plg.Generators.Playlist.Master do
  @audio_id "audio"
  @subtitles_id "subs"

  @spec generate(HLS.Plg.Types.Master.t) :: bitstring
  def generate(args) do
    "#{opening()}\n#{render_audio(args)}\n#{render_subtitles(args)}\n#{render_video(args)}"
  end

  defp opening do
    "#EXTM3U\n"
  end

  defp render_audio(args) do
    args.audio
    |> Enum.with_index
    |> Enum.reduce("", fn({row, index}, result) ->
         "#{result}#{render_audio_row(row, index == 0)}\n"
       end)
  end

  defp render_audio_row(row, default \\ false) when is_boolean(default) do
    ~s(#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="#{@audio_id}",LANGUAGE="#{row.language}",NAME="#{row.name}",DEFAULT=#{bool_to_render_format(default)},AUTOSELECT=YES,CHANNELS="#{row.channels}",URI="#{row.playlist_path}#{row.playlist_name}")
  end

  defp bool_to_render_format(flag) do
    if flag do
      "YES"
    else
      "NO"
    end
  end

  defp render_subtitles(args) do
    args.subtitles
    |> Enum.reduce("", fn(row, result) ->
      "#{result}#{render_subtitles_row(row)}\n"
    end)
  end

  defp render_subtitles_row(row, default \\ false) do
    ~s(#EXT-X-MEDIA:TYPE=SUBTITLES,GROUP-ID="#{@subtitles_id}",LANGUAGE="#{row.language}",NAME="#{row.name}",DEFAULT=#{bool_to_render_format(default)},AUTOSELECT=YES,FORCED=#{bool_to_render_format(row.forced)},URI="#{row.playlist_path}#{row.playlist_name}")
  end

  defp render_video(args) do
    args.video
    |> Enum.reduce("", fn(row, result) ->
      "#{result}#{render_video_row(row)}\n"
    end)
  end

  defp render_video_row(row) do
    ~s(#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=#{row.bandwidth},AUDIO="#{@audio_id}",SUBTITLES="#{@subtitles_id}",RESOLUTION=#{row.resolution},FRAME-RATE=#{row.framerate}\n#{row.playlist_path}#{row.playlist_name})
  end
end
