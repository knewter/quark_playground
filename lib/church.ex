defmodule Church do
  import Quark.Partial

  defpartial zero(f, x), do: x
  defpartial one(f, x), do: f.(x)
  defpartial two(f, x), do: f.(f.(x))
  defpartial lol_true(a, _b), do: a
  defpartial lol_false(_a, b), do: b
  defpartial is_zero(f) do
    l_x = fn _ -> lol_false end
    f.(l_x).(lol_true)
  end
  defpartial lol_test(b, x, y), do: b.(x).(y)
  defpartial lol_and(a, b) do
    a.(b).(lol_false)
  end
end
