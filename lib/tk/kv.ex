defmodule Tk.Kv do

  use GenServer

  def start do
    GenServer.start(__MODULE__, %{}, name: __MODULE__)
  end

  def set(key, value) do
    GenServer.cast(__MODULE__, {:set, key, value})
  end
    
  def get(key) do
    GenServer.call(__MODULE__, key)
  end
    
  


  def handle_cast({:set, key, value}, all_kvs) do
    {:noreply, Map.put(all_kvs, key, value) }
  end 

  def handle_call(key, _from, all_kvs) do
    {:reply, Dict.get(all_kvs, key), all_kvs}
  end
    


end

