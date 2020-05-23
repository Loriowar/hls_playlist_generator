defmodule HLS.Plg.Types.CommonContainer do
  defstruct audio: %{},
            subtitles: %{},
            video: %{}

  @type t ::
          %__MODULE__{
            audio: map,
            subtitles: map,
            video: map
          }
end
