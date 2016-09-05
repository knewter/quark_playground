defmodule Composed do
  import Quark.Compose

  def sum_plus_1, do: compose_list_forward([&Enum.sum/1, &(&1+1)])
end

defmodule Applied do
  use Quark.Partial

  defpartial add_mul(a, b, c), do: (a+b)*c
end

defmodule Curried do
  use Quark.Curry

  defcurry add(a, b), do: a + b
end


defmodule QuarkPlaygroundTest do
  use ExUnit.Case
  import Church
  @x 0
  @y 1

  test "basic currying" do
    assert 3 = Curried.add.(1).(2)
  end

  test "basic partial function application" do
    assert 9 = Applied.add_mul(1, 2).(3)
    assert 9 = Applied.add_mul(1, 2, 3)
    assert 9 = Applied.add_mul(1).(2).(3)
    assert 9 = Applied.add_mul.(1).(2).(3)
  end

  test "basic function composition" do
    assert 7 = Composed.sum_plus_1.([1, 2, 3])
  end

  test "function composition with infix pipe style operator" do
    import Quark.Compose

    add_1 = &(&1 + 1)
    # Here's the piped form
    assert 7 = [1,2,3] |> Enum.sum |> add_1.()
    # And here we've composed a function and pipe into that one function - they look very similar but fundamentally involve function composition in this style
    assert 7 = [1, 2, 3] |> (add_1 <|> &Enum.sum/1).()
  end

  # A church numeral applies a function n times
  test "church numeral 0" do
    assert @x = zero.(&f/1).(@x)
  end

  test "church numeral 1" do
    assert f(@x) == one.(&f/1).(@x)
  end

  test "church numeral 2" do
    assert @x |> f |> f == two.(&f/1).(@x)
  end

  test "church true" do
    assert @x == lol_true(@x, @y)
  end

  test "church false" do
    assert @y == lol_false(@x, @y)
  end

  test "church test" do
    assert @x == lol_test(lol_true, @x, @y)
  end

  test "church is_zero" do
    assert @x == lol_test(is_zero(zero), @x, @y)
    assert @y == lol_test(is_zero(one), @x, @y)
  end

  test "church and" do
    assert lol_false == lol_and(lol_true,  lol_false)
    assert lol_false == lol_and(lol_false, lol_true)
    assert lol_false == lol_and(lol_false, lol_false)
    assert lol_true  == lol_and(lol_true,  lol_true)
  end


  # test "church is_zero" do
  #   assert lol_true == is_zero(zero)
  #   assert lol_false == is_zero(one)
  # end

  # test "church if" do
  #   conditional = fn -> one.(&f/1).(@x) == one.(&f/1).(@x) end
  #   truthy = zero.(&f/1).(@x)
  #   falsy = one.(&f/1).(@x)
  #   assert our_if(conditional, truthy, falsy) == truthy
  # end

  def f(x), do: x - 5
end
