# DoNothingDsl

A Domain Specific Language for the [DoNothing Framework](https://github.com/erikareads/do_nothing).

## Usage

```elixir
#!/usr/bin/env elixir

Mix.install([{:do_nothing_dsl, github: "erikareads/do_nothing_dsl"}])

defmodule MyScript do
  use DoNothingDsl

  title "Example procedure"
  description "A description of the procedure..."

  step do
    title "A first step"
    instructions "The instructions to follow for the first step."
  end

  step do
    title "A second step"
    instructions "The instructions..."
  end
end

DoNothingDsl.parse(MyScript)
|> DoNothing.execute()
```

Running this will output:

```
# Example procedure

A description of the procedure...

[Enter] to begin

## A first step

The instructions to follow for the first step.

[Enter] when done

## A second step

The instructions...

[Enter] when done

done!
```
