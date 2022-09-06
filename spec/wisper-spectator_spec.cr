require "./spec_helper"

Spectator.describe "Wisper::Spectator" do
  subject { User::Create.new(15) }

  describe "#broadcast" do
    it "works with a passed event class" do
      expect { subject.call }.to broadcast(User::Create::Failure)
    end

    it "works with a negated matcher" do
      expect { subject.call }.not_to broadcast(User::Create::Success)
    end
  end
end
