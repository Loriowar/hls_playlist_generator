defmodule HLS.Plg.Types.Common do
  defstruct duration: nil,
            target_duration: 10,
            sequence_number: 0,
            segment_basename: "segment_",
            segment_number_length: 4,
            segment_extension: ""

  @type t ::
          %__MODULE__{
            duration: number,
            target_duration: number,
            sequence_number: integer,
            segment_basename: bitstring,
            segment_number_length: integer,
            segment_extension: bitstring
          }
end
