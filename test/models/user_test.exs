defmodule Tk.UserTest do
  use Tk.ModelCase

  alias Tk.User

  @valid_attrs %{comment: "some content", email: "some content", encrypted_password: "some content", organization_id: 42, tc: true, timezone: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
