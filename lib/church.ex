defmodule Church do
  import Quark.Partial

  defpartial zero(f, x), do: x
  defpartial one(f, x), do: f.(x)
  defpartial two(f, x), do: f.(f.(x))
end
