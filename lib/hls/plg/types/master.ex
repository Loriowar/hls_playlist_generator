defmodule HLS.Plg.Types.Master do
  defstruct audio: [],
            subtitles: [],
            video: []

  @type t ::
          %__MODULE__{
            audio: [HLS.Plg.Types.MasterRow.t],
            subtitles: [HLS.Plg.Types.MasterRow.t],
            video: [HLS.Plg.Types.MasterRow.t]
          }
end
