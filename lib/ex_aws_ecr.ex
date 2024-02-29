defmodule ExAws.ECR do
  @moduledoc """
  Operations on AWS ECR.

  [AWS ECR API Documentation](https://docs.aws.amazon.com/AmazonECR/latest/APIReference/API_Operations.html)
  """

  import ExAws.Utils, only: [camelize_keys: 1]

  alias ExAws.Operation
  alias ExAws.Operation.JSON

  @namespace "AmazonEC2ContainerRegistry_V20150921"
  @version "2015-09-21"

  @spec describe_images(binary, keyword) :: Operation.t()
  def describe_images(repository_name, opts \\ []) do
    %{
      "repositoryName" => repository_name
    }
    |> merge_opts(opts)
    |> request("DescribeImages")
  end

  @doc """
  Lists all the image IDs for the specified repository.
  """
  @spec list_images(binary, keyword) :: Operation.t()
  def list_images(repository_name, opts \\ []) do
    %{
      "repositoryName" => repository_name
    }
    |> merge_opts(opts)
    |> request("ListImages")
  end

  defp merge_opts(data, opts) do
    opts
    |> normalize_opts()
    |> Map.merge(data)
  end

  defp normalize_opts({k, v}, acc) do
    Map.put(acc, to_lower_camel_case(k), v)
  end

  defp normalize_opts(opts) do
    opts
    |> Enum.into(%{})
    |> camelize_keys()
    |> Enum.reduce(%{}, &normalize_opts/2)
  end

  defp to_lower_camel_case(string) do
    {first, rest} = String.split_at(string, 1)

    String.downcase(first) <> rest
  end

  defp request(data, action, opts \\ %{}) do
    data = Map.merge(%{"Version" => @version, "Action" => action}, data)

    JSON.new(
      :ecr,
      %{
        data: data,
        headers: [
          {"x-amz-target", "#{@namespace}.#{action}"},
          {"content-type", "application/x-amz-json-1.1"}
        ]
      }
      |> Map.merge(opts)
    )
  end
end
