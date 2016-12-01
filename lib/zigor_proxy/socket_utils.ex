defmodule ZigorProxy.SocketUtils do
  import ZigorProxy.BitConverter
  @moduledoc """
  This module helps with read and write from or to a Zigor socket.
  """

  ###
  # Socket Read Operations
  ###

  @doc "Reads 4 bytes from socket and converts it to signed number"
  def read_int32(socket) do
    socket |>
    read_bytes(4) |>
    get_int32
  end

  @doc "reads \"count\" bytes from \"socket\" and returns it as binary"
  def read_bytes(socket, count) do
    {:ok, data} = :gen_tcp.recv(socket, count)
    data
  end

  @doc "reads a single byte form socket and returns it as number"
  def read_byte(socket) do
    {:ok, << single >>} = :gen_tcp.recv(socket, 1)
    single
  end

  ###
  # Socket Write Operations
  ###

  @doc "writes data to socket"
  def write_bytes(socket, data) do
    :gen_tcp.send(socket, data)
  end

  @doc "writes a single byte to socket as a single element binary"
  def write_byte(socket, byte) do
    :gen_tcp.send(socket, <<byte>>)
  end

  @doc "writes an int32 to socket as a little endian binary"
  def write_int32(socket, number) do
    socket |>
    write_bytes(int32_bytes number)
  end
end
