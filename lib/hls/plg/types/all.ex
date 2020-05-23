defmodule HLS.Plg.Types.All do
  defstruct master: "",
            common: %{}

  @type t ::
          %__MODULE__{
            master: bitstring,
            common: map
          }
end
