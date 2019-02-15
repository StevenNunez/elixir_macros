defmodule ElixirMacros do
  defmacro wrap(function, message) do
    quote bind_quoted: [function: function, message: message] do
      case function.() do
        :ok -> :ok
        {:error, _} -> {:error, message}
      end
    end
  end

  defmacro wrap_s(functions) do
    quote bind_quoted: [functions: functions] do
      for {function, message} <- functions do
        case function.() do
          :ok -> :ok
          {:error, _} -> {:error, message}
        end
      end
    end
  end
end

IO.puts "require ElixirMacros"

IO.puts """
IO.inspect ElixirMacros.wrap_s([{fn -> :ok end, "Nothing"}, {fn -> {:error, "whoopsie"} end, "Something terrible happened"}])
"""
