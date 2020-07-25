defmodule InfoSys.Wolfram do
  import SweetXml
  alias InfoSys.Result

  @behaviour InfoSys.Backend

  @base "http://api.wolframalpha.com/v2/query?"

  @impl true
  def name, do: "wolfram"

  @impl true
  def compute(query_str, _opts) do
    IO.puts("TCL: InfoSys.Wolfram -> compute #{inspect(query_str)}")

    query_str
    |> fetch_xml()
    |> xpath(~x"/queryresult/pod[contains(@title, 'Result') or
                                 contains(@title, 'Definitions')]
                            /subpod/plaintext/text()")
    |> IO.inspect()
    |> build_results()
  end

  defp build_results(nil), do: []

  defp build_results(answer) do
    [%Result{backend: __MODULE__, score: 95, text: to_string(answer)}]
  end

  defp fetch_xml(query) do
    case :httpc.request(String.to_charlist(url(query))) do
      {:ok, {status_line, _, body}} ->
        IO.puts("TCL: status line, #{inspect(status_line)}")
        # IO.puts("TCL: httpc.request SUCCESS #{inspect(body)}")
        body

      {:error, {status_code, err_body}} ->
        IO.puts("TCL: Error #{inspect(status_code)}  #{inspect(err_body)}")
    end
  end

  defp url(input) do
    IO.puts("TCL: url")

    ("#{@base}" <>
       URI.encode_query(appid: id(), input: input, format: "plaintext"))
    |> IO.inspect()
  end

  defp id do
    Application.fetch_env!(:info_sys, :wolfram)[:app_id]
  end
end
