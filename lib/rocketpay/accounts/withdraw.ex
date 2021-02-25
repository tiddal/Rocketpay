defmodule Rocketpay.Accounts.Withdraw do
  alias Rocketpay.Accounts.Operation
  alias Rocketpay.Repo

  def call(params) do
    params
    |> Operation.call(:withdraw)
    |> run_transaction()
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:ok, %{withdraw: account}} -> {:ok, account}
      {:error, _operation, reason, _changes} -> {:error, reason}
    end
  end
end
