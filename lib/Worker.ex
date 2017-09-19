defmodule Project1.Worker do
   def run(server) do 
     #IO.puts("Worker is running")  
     client = Socket.UDP.open!(:rand.uniform(65536))
     
     Socket.Datagram.send(client, "hello", {server, 1337})
     {data, server } = client |> Socket.Datagram.recv!
     {num, _} = Integer.parse(data)
     #IO.puts(is_integer(num))
     #Project1.sha256HashWorker(num,server,client)
     Enum.each([1..50], fn(i) -> spawn(Project1, :sha256HashWorker, [num, server, client]) end)
     Enum.each([1..50], fn(i) -> spawn(Project1, :sha256HashWorker, [num, server, client]) end)
     Enum.each([1..50], fn(i) -> spawn(Project1, :sha256HashWorker, [num, server, client]) end)
     loop  #the purpose of loop here is to not let this thread to terminate, otherwise, the server
            #cannot receive what mined by the worker
   end   
   def loop do 
    loop 
  end 
end

#Worker.run()