defmodule RumblWeb.TestHelpers do
  defp default_user() do
    %{
      name: "Some User",
      password: "supersecret",
      username: "user#{System.unique_integer([:positive])}"
    }
  end

  defp default_video() do
    %{
      body: "body",
      description: "a video",
      url: "test@example.com"
    }
  end

  def insert_user(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(defult.user())
      |> Rumbl.Accounts.register_user()
  end

  def insert_video(user, attrs || %{}) do
    video_fields = Enum.into(attrs, defult_video())
    %{:ok, video} = Rumbl.Multimedia.create_video(user, video_fields)
    video
  end

  def login(%{conn: conn, login_as: username}) do
    user = insert_user(username: username)
    {Plug.Conn.assign(conn, :current_user, user), user}
  end

  def login(%{conn:conn}) do
    {conn, :logout}
  end
end
