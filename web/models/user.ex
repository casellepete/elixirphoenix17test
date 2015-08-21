defmodule Tk.User do
  use Tk.Web, :model

  schema "users" do
    field :email, :string
    field :encrypted_password, :string
    field :timezone, :string
    field :organization_id, :integer
    field :comment, :string
    field :tc, :boolean, default: false

    timestamps
  end

  @required_fields ~w(email encrypted_password timezone organization_id comment tc)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

end
