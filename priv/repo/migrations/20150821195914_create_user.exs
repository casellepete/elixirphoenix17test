defmodule Tk.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :encrypted_password, :string
      add :timezone, :string
      add :organization_id, :integer
      add :comment, :string
      add :tc, :boolean, default: false

      timestamps
    end

  end
end
