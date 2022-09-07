# wisper-spectator
Handy test helpers for [Wisper.cr](https://github.com/gmartsenkov/wisper.cr)
Only compatible with the (Spectator)(https://github.com/icy-arctic-fox/spectator/) testing framework.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   development_dependencies:
     wisper-spectator:
       github: gmartsenkov/wisper-spectator
   ```

2. Run `shards install`

## Usage

```crystal
require "wisper-spectator"

Spectator.describe "Wisper::Spectator" do
  subject { User::Create.new(15) }

  describe "#broadcast" do
    it "works with a passed event class" do
      subject.on(User::Create::Failure) do |failure|
        expect(failure.reason).to eq "Some reason"
      end
      expect { subject.call }.to broadcast(User::Create::Failure)
    end
  end
end
```

TODO: Write usage instructions here

## Development

TODO: Write development instructions here

## Contributing

1. Fork it (<https://github.com/gmartsenkov/wisper-spectator/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Georgi Martsenkov](https://github.com/gmartsenkov) - creator and maintainer
