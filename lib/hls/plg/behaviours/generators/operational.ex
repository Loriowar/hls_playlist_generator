defmodule HLS.Plg.Behaviours.Generators.Operational do
  @callback generate(duration :: number) :: result :: String.t
  @callback generate(args :: HLS.Plg.Types.Common.t) :: result :: String.t
  @callback opening(args :: HLS.Plg.Types.Common.t) :: result :: String.t
  @callback ending(args :: HLS.Plg.Types.Common.t) :: result :: String.t
  @callback playlist_args(duration :: number, sequence_number :: integer) :: result :: String.t
end
