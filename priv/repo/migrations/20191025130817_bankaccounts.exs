defmodule ElixirHelper.Repo.Migrations.Bankaccounts do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :value, :string
    end
  end
end
