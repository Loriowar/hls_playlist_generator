defmodule HLS.Plg.Types.MasterRow do
  defstruct language: "en",
            name: "English",
            forced: false,
            bandwidth: 510000,
            resolution: "640x480",
            channels: 2,
            playlist_path: "",
            playlist_name: "playlist.m3u8",
            details: %HLS.Plg.Types.Common{}

  @type t ::
          %__MODULE__{
            language: bitstring,
            name: bitstring,
            forced: boolean,
            bandwidth: integer,
            resolution: bitstring,
            channels: integer,
            playlist_path: bitstring,
            playlist_name: bitstring,
            details: HLS.Plg.Types.Common.t
          }
end
