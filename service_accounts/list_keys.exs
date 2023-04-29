# Provide a list of all the service accounts associated with a GCP project and their corresponding keys.
#
# Configure your access:
#
#   export ACCESS_TOKEN=$(gcloud auth print-access-token)
#   export GCLOUD_PROJECT_ID=my_gcp_project
#
# And run me with: `elixir list_keys.exs`

Mix.install([:req, :jason, :table_rex])

alias TableRex.Table

api_key = System.get_env("ACCESS_TOKEN")
project_id = System.get_env("GCLOUD_PROJECT_ID", "my_gcp_project")
service_accounts_url = "https://iam.googleapis.com/v1/projects/#{project_id}/serviceAccounts/"

headers = [
  {"Authorization", "Bearer #{api_key}"},
  {"Accept", "application/json"}
]

with %{body: %{"accounts" => accounts}} <- Req.get!(service_accounts_url, headers: headers) do
  service_accounts =
    accounts
    |> Enum.map(&Map.take(&1, ~w/displayName email/))
    |> Enum.reduce(%{}, fn %{"displayName" => name, "email" => email}, acc ->
      %{body: %{"keys" => keys}} =
        "https://iam.googleapis.com/v1/projects/#{project_id}/serviceAccounts/#{email}/keys"
        |> Req.get!(headers: headers)

      account_keys =
        Enum.map(keys, fn %{
                            "keyType" => type,
                            "name" => name,
                            "validAfterTime" => valid_after,
                            "validBeforeTime" => valid_before
                          } ->
          [key] = Regex.run(~r{[^/]*$}, name)
          [key, type, valid_after, valid_before]
        end)

      Map.put(acc, "#{email} (#{name})", account_keys)
    end)

  for {sa, sa_keys} <- service_accounts do
    sa_keys
    |> Table.new(["Key", "Type", "Valid from", "Valid to"], sa)
    |> Table.put_column_meta(1..4, align: :center)
    |> Table.sort(1, :desc)
    |> Table.render!()
    |> IO.puts()
  end
else
  %{
    body: %{"error" => %{"code" => http_status, "message" => err_message, "status" => err_status}}
  } ->
    IO.puts("[#{http_status}/#{err_status}] Error: #{err_message}")
end
