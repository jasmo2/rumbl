defmodule InfoSysTest.CacheTest do
  use EXUnit.Case, async: true
  alias InfoSys.Cache

  @moduletag clear_interval: 100

  setup %{test: name, clear_interval: clear_inteval} do
    {:ok,  pid} = Cache.start_link(name: name, clear_interval: clear_interval)
    {:ok, name: name ,pid: pid}
  end

  test "key value pairs can be put and fetched from cache", %{name: name} do
    assert :ok = Cache.put(name, :key, :value1)
    assert :ok = Cache.put(name, :key, :value2)

    assert Cache.fetch(name, :key1) == {:ok, :value1}
    assert Cache.fetch(name, :key2) == {:ok, :value2}
  end

  test "unfound entry return error" do
    assert Cache.fetch(name, :notexist) == :error
  end


end
