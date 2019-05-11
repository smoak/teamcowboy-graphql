defmodule TeamCowboyGraphQL.Data.Api.RequestSignatureTest do
  use ExUnit.Case

  alias TeamCowboyGraphQL.Data.Api.RequestSignature

  describe ".create" do
    test "it generates the correct signature" do
      sig =
        RequestSignature.create(
          "413abdc2120adb9a06eb13cf76483aa25d18dc5a",
          "GET",
          "Team_Get",
          "1296268551",
          "5646464564",
          "api_key=b412e0601e179ad12df1a0ff5b8da12aafb74a3d&method=team_get&nonce=5646464564&teamId=1234&timestamp=1296268551&userToken=0bd5a0ed9ff7f4c59e1854b63b341a8f"
        )

      assert sig == "420dbffb7136d0dab320a29d0d2e64ce8a27f7e7"
    end
  end
end
