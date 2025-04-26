defmodule WendigoWeb.Middleware.ErrorReporter do
  @behaviour Absinthe.Middleware

  def call(resolution, _config) do
    case resolution.errors do
      [] -> resolution
      errors ->
        if span = Appsignal.Tracer.current_span() do
          formatted_errors = Enum.map(errors, &format_error/1)
          error_message = Enum.join(formatted_errors, ", ")

          error = %RuntimeError{
            message: error_message
          }

          Appsignal.Span.add_error(
            span,
            error,
            %{
              graphql_error: true,
              validation_error: true
            }
          )

          Appsignal.Span.set_sample_data(span, "graphql", %{
            query: resolution.definition.name || "anonymous",
            path: Absinthe.Resolution.path(resolution)
          })
        end

        resolution
    end
  end

  defp format_error(%{message: message}), do: message
  defp format_error(error), do: inspect(error)
end
