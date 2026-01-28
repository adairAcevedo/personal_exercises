defmodule Yair do
    def send_msg() do
      parent = self()
      #spawn(fn -> send(parent, {:liquidation, %{days_work: "700", salary_per_day: "500"}}) end)
      spawn(fn ->  send(parent, raise "oops") end)


      receive do
          {:hi, _msg} -> "say hi from #{inspect parent}"
          {:raise, _msg} -> raise("exception to receive msg")
          {:liquidation, data} ->
            final = (data.days_work * data.salary_per_day) * 0.25
            "liquidation is #{final}"

          {:hello, _msg} -> "say hello from #{ inspect parent}"
      after
        10_000 -> "not receive msg"

      end
  end



  def calculate_liquidation(msg) do
      parent = self()
      spawn(fn -> send(parent, {:liquidation, %{days_work: 700, salary_per_day: 2000}}) end)

      receive do
          {:liquidation, data} ->
            final = (data.days_work * data.salary_per_day) * 0.25
            "liquidation is #{final}"
          {:hello, msg} -> "say hello from #{ inspect parent}"
      end
  end

end
