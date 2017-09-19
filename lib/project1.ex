defmodule Project1 do
  @moduledoc """
  Documentation for Project1.
  """

  @doc """

  ## Examples

  """
  def get_num() do
    num_str = IO.gets("./project1 ")
    |> String.trim
    num = String.to_integer(num_str)
    num
  end

  def get_string() do
    random_number = :rand.uniform(100)
    randomizer(random_number)
  end 

  def randomizer(length) do 
    alphabets = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    numbers = "0123456789"
    lists = (alphabets <> String.downcase(alphabets) <> numbers)
            |> String.split("", trim: true)
    do_randomizer(length, lists)
  end 

  defp do_randomizer(length, lists) do 
    get_range(length)
    |> Enum.reduce([], fn(_, acc)->[Enum.random(lists) | acc] end )
    |> Enum.join("")
  end   

  defp get_range(length) when length > 1, do: (1..length)
  defp get_range(length), do: [1]

  def sha256HashWorker(num, server, client) do 
    hashString = get_string()   
    #IO.puts(hashString)
    inString = "zhaikeke;"<>hashString
    outString = :crypto.hash(:sha256, inString)|>Base.encode16
    baseNum = String.duplicate("0", num)<>String.duplicate("f", 64-num)
    if(outString <= baseNum ) do 
      Socket.Datagram.send(client, inString<>"\t"<>outString, server)
    end  
    sha256HashWorker(num, server, client)
  end   

  def sha256HashServer(num) do 
    hashString = get_string() 
    inString = "zhaikeke;"<>hashString
    outString = :crypto.hash(:sha256, inString)|>Base.encode16
    baseNum = String.duplicate("0", num)<>String.duplicate("f", 64-num)
    if(outString <= baseNum ) do 
      IO.puts(inString<>"\t"<>outString)
    end  
    sha256HashServer(num)
  end
 
end


defmodule Project1.CLI do 
  def main(args \\[]) do  #main function
    #IO.puts(args)
    #IO.puts(is_number(args))
    {opts,word,_}= args |> OptionParser.parse
    [head | tail] = word 
    if(head =~ ".") do 
      Project1.Worker.run(head)
    else
      Project1.Server.run(head)
    end     
  end   
end 