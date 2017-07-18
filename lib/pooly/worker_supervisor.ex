defmodule Pooly.WorkerSupervisor do
  use Supervisor

  # API

  # module, function, list of worker arguments
  def start_link({_, _, _} = mfa) do
    Supervisor.start_link(__MODULE__, mfa)
  end

  # Callbacks

  def init({m, f, a}) do
    # child specification
    children = [ worker(m, a, [restart: :permanent, function: f]) ]

    # supervisor specification (requires child specification)
    supervise(children,
              [strategy: :simple_one_for_one,
               max_restarts: 5,
               max_seconds: 5])
  end

end
