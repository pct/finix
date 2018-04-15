defmodule Finix.Controller do
  defmacro __using__(_opts) do
    quote do
      import Finix.Controller.Helpers

      def init(opts), do: opts

      def call(conn, opts) do
        apply __MODULE__, opts[:action], [conn, conn.params]
      end
    end
  end
end
