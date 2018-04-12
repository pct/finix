defmodule Finix.Controller do
  defmacro __using__(_opts) do
    quote do

      def init(opts), do: opts

      def call(conn, opts) do
        apply __MODULE__, opts[:action], [conn, conn.params]
      end

      def render(conn, file_name, params) do
        ret = __ENV__.file
        |> Path.dirname
        |> Path.join(["../views/", file_name])
        |> EEx.eval_file(params)

        conn
        |> Plug.Conn.put_resp_content_type("text/html")
        |> Plug.Conn.send_resp(200, ret)
      end

    end
  end
end
