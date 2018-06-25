defmodule Chitchat do
  def hidden?(item) do
    !String.starts_with?(item, ".")
  end

  def item_is(type, item, dir) do
    full_path = Path.join(dir, item)
    case type do
      :folder -> File.dir?(full_path)
      :file -> !File.dir?(full_path)
    end
  end

  def pipe(is_last) do
    case is_last do
      false -> "├──"
      true -> "└──"
    end
  end

  def dir_list(dir \\ ".") do
    depth = length Path.split(dir)
    padding = String.duplicate("   ", depth - 1)

    items = Enum.filter(File.ls!(dir), fn item -> hidden?(item) end)

    files = Enum.filter(items, fn item -> item_is(:file, item, dir) end)
    folders = Enum.filter(items, fn item -> item_is(:folder, item, dir) end)

    for {file, i} <- Enum.with_index(files) do
      is_last = length(files) - 1 == i
      IO.puts padding <> pipe(is_last) <> file
    end

    for {folder, i} <- Enum.with_index(folders) do
      is_last = length(folders) - 1 == i
      IO.puts padding <> pipe(is_last) <> folder
      dir_list Path.join(dir, folder)
    end
  end

  def print_tree do
    IO.puts "."
    dir_list()
  end
end

Chitchat.print_tree

