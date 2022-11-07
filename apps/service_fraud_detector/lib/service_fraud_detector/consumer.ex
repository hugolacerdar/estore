defmodule ServiceFraudDetector.Consumer do
  use Broadway

  alias Broadway.Message

  @topics ["ECOMMERCE_NEW_ORDER"]
  @group_id "FRAUD_DETECT_GROUP"

  def start_link(_opts) do
    Broadway.start_link(__MODULE__,
      name: __MODULE__,
      producer: [
        module:
          {BroadwayKafka.Producer,
           [
             hosts: [localhost: 9092],
             group_id: @group_id,
             topics: @topics
           ]},
        concurrency: 3
      ],
      processors: [
        default: [
          concurrency: 10
        ]
      ],
      batchers: [
        default: [
          batch_size: 10,
          batch_timeout: 200,
          concurrency: 10
        ]
      ]
    )
  end

  @impl true
  def handle_message(_, message, _) do
    Message.update_data(message, fn data -> {data, Serializer.reverse(data)} end)
  end

  @impl true
  def handle_batch(_, messages, %_{partition: partition}, _) do
    list = messages |> Enum.map(fn e -> e.data end)
    IO.inspect(list, label: "#{__MODULE__} got batch from partition #{partition}")
    messages
  end
end
