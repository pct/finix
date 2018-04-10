# Finix Framework
參考 sugar, trot, phoenix 用的套件，組 framework

## Usage

add `{:finix, github: "pct/finix"}` to your mix.exs:

```elixir
defp deps do
  [
    {:finix, github: "pct/finix"},
    {:exsync, "~> 0.2", only: :dev} # if you need auto recompile
  ]
end
```   

add the following code to your `def start` function head if you want to auto recompile

```elixir
# exsync reload
case Code.ensure_loaded(ExSync) do
  {:module, ExSync = mod} ->
    mod.start()
  {:error, :nofile} ->
    :ok
end
```

# Plugs
- cowboy https://github.com/ninenines/cowboy
- plug https://github.com/elixir-plug/plug

## from sugar
- http_router https://github.com/sugar-framework/elixir-http-router/
- earmark (markdown parser) https://github.com/pragdave/earmark
- ex_doc (doc) https://github.com/elixir-lang/ex_doc
- excoveralls (coverage report) https://github.com/parroty/excoveralls
- dialyxir (task) https://github.com/jeremyjh/dialyxir

## from phoenix
- jason (json) https://github.com/michalmuskala/jason

## from trot
- inch_ex (inline) https://github.com/rrrene/inch_ex
- credo (static code analysis) https://github.com/rrrene/credo

## Me
- Expug (pug) https://github.com/rstacruz/expug
- exi18n (i18n) https://github.com/gvl/exi18n
- exsync (reload) https://github.com/falood/exsync

# TODO
- server https://github.com/sugar-framework/sugar/blob/master/lib/mix/tasks/server.ex
- livereload
- mix tasks
