defmodule TeamCowboyGraphQL.Data.Api.RequestSignatureTest do
  use ExUnit.Case

  alias TeamCowboyGraphQL.Data.Api.RequestSignature

  describe ".create" do
    test "it generates the correct signature" do
      sig =
        RequestSignature.create(
          "GET",
          "Team_Get",
          %{
            method: "Team_Get",
            api_key: "b412e0601e179ad12df1a0ff5b8da12aafb74a3d",
            teamId: "1234",
            userToken: "0bd5a0ed9ff7f4c59e1854b63b341a8f",
            nonce: "5646464564",
            timestamp: "1296268551"
          }
        )

      assert sig == "ccea4bba78db6bb32cf953e6cce610b2c6d60068"
    end
  end
end
