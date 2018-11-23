defmodule TeamCowboyGraphQL.Data.RequestTest do
  use ExUnit.Case

  alias TeamCowboyGraphQL.Data.Request

  describe ".create_signature" do
    test "it generates the corrent signature" do
      sig =
        Request.create_signature(
          "GET",
          "Team_Get",
          %{
            method: "Team_Get",
            api_key: "b412e0601e179ad12df1a0ff5b8da12aafb74a3d",
            teamId: "1234",
            userToken: "0bd5a0ed9ff7f4c59e1854b63b341a8f"
          },
          fn -> 1_296_268_551 end,
          fn -> 5_646_464_564 end
        )

      assert sig == "420dbffb7136d0dab320a29d0d2e64ce8a27f7e7"
    end
  end
end
