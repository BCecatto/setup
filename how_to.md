### Install old erlang verion on MacOs when asdf not works properlyg:
```
brew install erlang@22
cp -r /opt/homebrew/opt/erlang@22/lib/erlang ~/.asdf/installs/erlang/22.3.4.21
asdf reshim erlang 22.3.4.21
```

### Copy to clipboard inside elixir terminal
```
 port = Port.open({:spawn, "pbcopy"}, [])
    true = Port.command(port, text)
    true = Port.close(port)
```

### Measure function time
```
defmodule Benchmark do
  def measure(function) do
    function
    |> :timer.tc
    |> elem(0)
    |> Kernel./(1_000_000)
  end
end
```
