defmodule DoNothingDsl do
  use Spark.Dsl,
    default_extensions: [extensions: DoNothingDsl.Extension]

  def parse(module) do
    %DoNothing.Procedure{
      title: Spark.Dsl.Extension.get_opt(module, [:procedure], :title),
      description: Spark.Dsl.Extension.get_opt(module, [:procedure], :description),
      steps: Spark.Dsl.Extension.get_entities(module, [:procedure])
    }
  end
end
defmodule DoNothingDsl.Extension do
  @step_schema [
    title: [
      type: :string,
      required: true
    ],
    instructions: [
      type: :string,
      required: false
    ]
  ]

  @step %Spark.Dsl.Entity{
    name: :step,
    describe: "Adds a step",
    target: DoNothing.Step,
    entities: [
      automation: [
        %Spark.Dsl.Entity{
          name: :automation,
          target: DoNothing.Automation,
          schema: [
            inputs: [type: {:list, :atom}, required: false],
            output: [type: :atom, required: false],
            execute: [type: :fun, required: true]
          ],
          transform: {DoNothing.Extension, :confirm_arity, []}
        }
      ]
    ],
    singleton_entity_keys: [:automation],
    schema: @step_schema
  }

  @doc false
  def confirm_arity(run) do
    {:arity, function_arity} = Function.info(run.execute, :arity)
    inputs_length = length(run.inputs)

    if function_arity === inputs_length do
      {:ok, run}
    else
      {:error,
       "execute has arity #{function_arity}, but inputs has length #{inputs_length}, these must match"}
    end
  end

  @procedure %Spark.Dsl.Section{
    # The DSL constructor will be `procedure`
    name: :procedure,
    describe: """
    Configure the DoNothing procedure.
    """,
    entities: [
      # See `Spark.Dsl.Entity` docs
      @step
    ],
    top_level?: true,
    schema: [
      title: [
        type: :string
      ],
      description: [
        type: :string
      ]
    ]
  }

  use Spark.Dsl.Extension, sections: [@procedure]
end
