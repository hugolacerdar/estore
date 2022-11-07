defmodule Serializer do
  @moduledoc false

  @spec process(term) :: binary
  def process(term) do
    term
    |> :erlang.term_to_binary()
    |> Base.encode64()
  end

  @spec reverse(binary) :: String.t() | map
  def reverse(binary) do
    binary
    |> Base.decode64!()
    |> :erlang.binary_to_term()
  end
end
