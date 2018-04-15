# https://github.com/sugar-framework/sugar/blob/master/lib/sugar/controller/helpers.ex
defmodule Finix.Controller.Helpers do
  @type status_code :: 100..999
  @type headers :: [{binary, binary}]

  import Plug.Conn

  @spec status(Plug.Conn.t, status_code) :: Plug.Conn.t
  def status(conn, status_code) do
    %Plug.Conn{conn | status: status_code, state: :set}
  end

  @spec headers(Plug.Conn.t, headers) :: Plug.Conn.t
  def headers(conn, headers) do
    %Plug.Conn{conn | resp_headers: headers, state: :set}
  end

  @spec static(Plug.Conn.t, binary) :: Plug.Conn.t
  def static(conn, file) do
    filename = Path.join(["priv/static", file])
    if File.exists?(filename) do
      body = filename |> File.read!
      conn
      |> put_resp_content_type("text/html")
      |> send_resp(200, body)
    else
      conn
      |> not_found
    end
  end

  @spec json(Plug.Conn.t, Keyword.t | list, Keyword.t) :: Plug.Conn.t
  def json(conn, data, opts \\ []) do
    opts = [status: conn.status || 200] |> Keyword.merge(opts)
    header = get_resp_header(conn, "content-type")

    conn = if header == [] or not (header |> hd =~ "json") do
      put_resp_content_type(conn, "application/json")
    else
      conn
    end

    conn
    |> send_resp(opts[:status], Poison.encode! data)
  end

  @spec raw(Plug.Conn.t) :: Plug.Conn.t
  def raw(conn) do
    conn |> send_resp
  end

  @spec render(Plug.Conn.t, binary | Keyword.t | nil, Keyword.t, Keyword.t) :: Plug.Conn.t
  def render(conn, template \\ nil, assigns \\ [], opts \\ [])
  def render(conn, template, assigns, opts) when is_atom(template)
  or is_binary(template) do
    template = build_template_key(conn, template)
    render_view(conn, template, assigns, opts)
  end
  def render(conn, assigns, opts, _) when is_list(assigns) do
    template = build_template_key(conn)
    render_view(conn, template, assigns, opts)
  end

  @spec halt!(Plug.Conn.t, Keyword.t) :: Plug.Conn.t
  def halt!(conn, opts \\ []) do
    opts = [status: 401, message: ""] |> Keyword.merge(opts)
    conn
    |> send_resp(opts[:status], opts[:message])
  end

  @spec not_found(Plug.Conn.t, binary) :: Plug.Conn.t
  def not_found(conn, message \\ "Not Found") do
    conn
    |> send_resp(404, message)
  end

  @spec forward(Plug.Conn.t, atom, atom, Keyword.t) :: Plug.Conn.t
  def forward(conn, controller, action, args \\ []) do
    apply(controller, action, [conn, args])
  end

  @spec redirect(Plug.Conn.t, binary, Keyword.t) :: Plug.Conn.t
  def redirect(conn, location, opts \\ []) do
    opts = [status: 302] |> Keyword.merge(opts)
    conn
    |> put_resp_header("location", location)
    |> send_resp(opts[:status], "")
  end

  defp build_template_key(conn, template \\ nil) do
    default = Map.get(conn.private, :action) || :index
    template = template || default

    controller = "#{Map.get(conn.private, :controller, "")}"
                 |> String.split(".")
                 |> List.last
                 |> String.downcase

    "#{controller}/#{template}"
  end

  defp render_view(conn, template_key, assigns, opts) do
    opts = [status: 200] |> Keyword.merge(opts)
    header = get_resp_header(conn, "content-type")

    conn = if header == [] or not (header |> hd =~ "json") do
      put_resp_content_type(conn, opts[:content_type] || "text/html")
    else
      conn
    end

    html = Finix.Config.get(:finix, :views_path, "lib/web/views")
           |> Path.join("#{template_key}.eex")
           |> EEx.eval_file(assigns)

    conn
    |> send_resp(opts[:status], html)
  end
end
