defmodule HLS.Plg.Types.MasterRow do
  defstruct language: "en",
            name: "English",
            forced: false,
            bandwidth: 510000,
            resolution: "640x480",
            path: "playlist.m3u8"

  @type t ::
          %__MODULE__{
            language: bitstring,
            name: bitstring,
            forced: boolean,
            bandwidth: integer,
            resolution: bitstring,
            path: bitstring
          }
end
