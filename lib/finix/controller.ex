defmodule Finix.Controller do
  defmacro __using__(_opts) do
    quote do

      def init(opts), do: opts

      def call(conn, opts) do
        apply __MODULE__, opts[:action], [conn, conn.params]
      end

      def render(conn, template \\ nil, assigns \\ [], opts \\ [])
      def render(conn, template, assigns, opts) when is_atom(template) or is_binary(template) do
        ret = conn
        |> get_template_path(template)
        |> EEx.eval_file(assigns)

        conn |> conn_resp(ret)
      end
      def render(conn, assigns, opts, _) when is_list(assigns) do
        ret = conn
        |> get_template_path
        |> EEx.eval_file(assigns)

        conn |> conn_resp(ret)
      end

      defp get_template_path(conn, template \\ nil) do
        default = Map.get(conn.private, :action) || :index
        template = template || default

        controller = "#{Map.get(conn.private, :controller, "")}"
        |> String.split(".")
        |> List.last
        |> String.downcase

        view_path = __ENV__.file
        |> Path.dirname
        |> Path.join(["../views/", "#{controller}/#{template}.eex"])
      end

      defp conn_resp(conn, ret) do
        conn
        |> Plug.Conn.put_resp_content_type("text/html")
        |> Plug.Conn.send_resp(200, ret)
      end
    end
  end
end
