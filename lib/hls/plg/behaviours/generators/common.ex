defmodule HLS.Plg.Behaviours.Generators.Common do
  @callback generate(args :: HLS.Plg.Types.Common.t, opening :: String.t, ending :: String.t) :: result :: String.t
end
