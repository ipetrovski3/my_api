# frozen_string_literal: true

module ResponseHelpers
  def json_response_body
    JSON.load(response.body)
  end
end
