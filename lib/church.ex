defmodule Church do
  import Quark.Partial

  # THIS IS THE IMPORTANT PART!
  # ZERO MEANS NO FUNCTION APPLICATION!!!
  defpartial zero(_f, x), do: x
  defpartial one(f, x), do: f.(x)
  defpartial two(f, x), do: f.(f.(x))
  defpartial lol_true(a, _b), do: a
  defpartial lol_false(_a, b), do: b
  defpartial is_zero(f) do
    l_x = fn _ -> lol_false end
    f.(l_x).(lol_true)
  end
  # DOMAIN IS BOOLEANS (lol_true, lol_false)
  defpartial lol_and(a, b) do
    a.(b).(lol_false)
  end
  defpartial lol_or(a, b) do
    a.(lol_true).(b)
  end
end
