defmodule Finix.Controller do
  defmacro __using__(_opts) do
    quote do
      import Finix.Controller.Helpers

      plug Plug.Static, from: Finix.Config.get(:finix, :static_path, "priv/static")

      def init(opts), do: opts

      def call(conn, opts) do
        apply __MODULE__, opts[:action], [conn, conn.params]
      end
    end
  end
end
