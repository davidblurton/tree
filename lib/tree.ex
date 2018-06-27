defmodule Files do
  def print([file, next | more], tree) do
    IO.puts tree <> "├── " <> file
    print([next | more], tree)
  end

  def print([file | _], tree) do
    IO.puts tree <> "└── " <> file
  end

  def print([], _) do end
end

defmodule Folders do
  def print([folder, next | more], dir, tree) do
    IO.puts tree <> "├── " <> folder
    Tree.dir_list(Path.join(dir, folder), tree <> "│   ")
    
    print([next | more], dir, tree)
  end

  def print([folder | _], dir, tree) do
    IO.puts tree <> "└── " <> folder
    Tree.dir_list(Path.join(dir, folder), tree <> "    ")
  end

  def print([], _, _) do end
end

defmodule Tree do  
  def dir_list(dir \\ ".", tree \\ "") do
    items = for item <- File.ls!(dir), String.first(item) != "." do item end
    {folders, files} = Enum.split_with(items, fn item -> File.dir?(Path.join(dir, item)) end)
      
    Files.print files, tree
    Folders.print folders, dir, tree
  end

  def print do
    IO.puts "."
    dir_list()
  end
end

Tree.print

