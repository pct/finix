defmodule Finix.Controller do
  defmacro __using__(_opts) do
    quote do

      def init(opts), do: opts

      def call(conn, opts) do
        apply __MODULE__, opts[:action], [conn, conn.params]
      end

      def render(file_name, params) do
        __ENV__.file
        |> Path.dirname
        |> Path.join(["../views/", file_name])
        |> EEx.eval_file(params)
      end

    end
  end
end