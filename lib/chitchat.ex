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

  def dir_list(dir \\ ".") do
    depth = length Path.split(dir)
    padding = String.duplicate("  ", depth - 1)

    items = Enum.filter(File.ls!(dir), fn item -> hidden?(item) end)

    files = Enum.filter(items, fn item -> item_is(:file, item, dir) end)
    folders = Enum.filter(items, fn item -> item_is(:folder, item, dir) end)

    for file <- files do
      IO.puts padding <> file
    end

    for folder <- folders do
      IO.puts padding <> folder
      dir_list Path.join(dir, folder)
    end
  end
end

Chitchat.dir_list

