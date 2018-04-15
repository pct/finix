defmodule Finix.Router do
  defmacro __using__(_opts) do
    quote do
      use HttpRouter
    end
  end
end
