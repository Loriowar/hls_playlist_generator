defmodule HLS.Plg.Types.MasterRow do
  defstruct language: "en",
            name: "English",
            forced: false,
            bandwidth: 510000,
            resolution: "640x480",
            framerate: 24,
            channels: 2,
            playlist_path: "",
            playlist_name: "playlist.m3u8",
            details: %HLS.Plg.Types.Common{},
            meta: %{}

  @type t ::
          %__MODULE__{
            language: bitstring,
            name: bitstring,
            forced: boolean,
            bandwidth: integer,
            resolution: bitstring,
            framerate: number,
            channels: integer,
            playlist_path: bitstring,
            playlist_name: bitstring,
            details: HLS.Plg.Types.Common.t,
            meta: map
          }
end
