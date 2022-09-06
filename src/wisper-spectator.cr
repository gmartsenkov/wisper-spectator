require "spectator"
require "wisper"

struct WisperBroadcastMatcher(ExpectedType) < Spectator::Matchers::ValueMatcher(ExpectedType)
  # Short text about the matcher's purpose.
  # This explains what condition satisfies the matcher.
  # The description is used when the one-liner syntax is used.

  @events = Array(Wisper::EventTypes).new

  def description : String
    "broadcasted #{expected.label}"
  end

  # Checks whether the matcher is satisfied with the expression given to it.
  private def match?(actual : Spectator::Expression(T)) : Bool forall T
    handler = ->(event : Wisper::EventTypes) do
      @events << event
    end

    Wisper.listen(handler) do
      actual.value
    end

    @events.map(&.class).includes?(expected.value)
  end

    private def values(actual : Spectator::Expression(T)) forall T
      {
        broadcasted: @events.inspect,
        expected: expected.value.inspect
      }
    end

    private def negated_values(actual : Spectator::Expression(T)) forall T
      {
        broadcasted: @events.inspect
      }
    end

  # Message displayed when the matcher isn't satisfied.
  # The message should typically only contain the test expression labels.
  private def failure_message(actual : Spectator::Expression(T)) : String forall T
    "Expected #{actual.label} to broadcast #{expected.label}"
  end

  private def failure_message_when_negated(actual : Spectator::Expression(T)) : String forall T
    "Expected #{actual.label} not to broadcast #{expected.label} but it did"
  end
end

# The DSL portion of the matcher.
# This captures the test expression and creates an instance of the matcher.
macro broadcast(expected)
  %value = ::Spectator::Value.new({{expected}}, {{expected.stringify}})
  WisperBroadcastMatcher.new(%value)
end
