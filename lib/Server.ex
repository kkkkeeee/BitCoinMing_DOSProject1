defmodule Project1.Server do
   def run(num) do 
     server = Socket.UDP.open!(1337)
     
     pid1 = spawn(fn-> receiveData(server, num) end)
     {num, _} = Integer.parse(num)
     #pid2 = spawn(fn-> Project1.sha256HashServer(num) end)
     Enum.each([1..50], fn(i) -> spawn(Project1, :sha256HashServer, [num]) end)
     Enum.each([1..50], fn(i) -> spawn(Project1, :sha256HashServer, [num]) end)
     Enum.each([1..50], fn(i) -> spawn(Project1, :sha256HashServer, [num]) end)
     #copy so many enum is to make more cores working
     loop
   end 

   def receiveData(server, num) do 
     #IO.puts("Server is running")   
     { data, client } = server |> Socket.Datagram.recv!
     
     if(data == "hello") do 
       #client |> Socket.Datagram.send! num, server
       Socket.Datagram.send(server, num, client)
       #IO.puts("send num to worker")
     else
       IO.puts(data)
     end  
     receiveData(server, num)
  end 
  
  def loop do 
    loop 
  end  
end

