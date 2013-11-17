require 'pnr_service'

describe PnrService, "#status" do
  it "return status of a valid pnr" do
    PnrService.status("4157218518").should == {
      :pnr => "4157218518",
      :valid => true,
      :chart_status => "CHART NOT PREPARED",
      :passengers => [
        ["S7  , 65,SS", "CNF"]
      ]
    }
  end
end
