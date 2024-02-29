defmodule ExAws.ECRTest do
  use ExUnit.Case, async: true
  doctest ExAws.ECR

  @namespace "AmazonEC2ContainerRegistry_V20150921"
  @version "2015-09-21"
  @repo "my-repo"

  def expected_namespace(), do: @namespace
  def expected_version(), do: @version
  def expected_repo(), do: @repo

  defp expected_headers(action) do
    [
      {"x-amz-target", "#{expected_namespace()}.#{action}"},
      {"content-type", "application/x-amz-json-1.1"}
    ]
  end

  test "describe_images" do
    req = ExAws.ECR.describe_images(expected_repo(), filter: %{"tagStatus" => "TAGGED"})

    assert req.data == %{
             "Action" => "DescribeImages",
             "Version" => expected_version(),
             "repositoryName" => expected_repo(),
             "filter" => %{"tagStatus" => "TAGGED"}
           }

    assert req.headers == expected_headers("DescribeImages")
  end

  test "list_images" do
    req = ExAws.ECR.list_images(expected_repo(), filter: %{"tagStatus" => "TAGGED"})

    assert req.data == %{
             "Action" => "ListImages",
             "Version" => expected_version(),
             "repositoryName" => expected_repo(),
             "filter" => %{"tagStatus" => "TAGGED"}
           }

    assert req.headers == expected_headers("ListImages")
  end
end
