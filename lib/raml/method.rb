module Raml
  class Method
    ATTRIBUTES = %w[description headers]

    attr_accessor :action, :description, :headers, :responses, :query_parameters

    def initialize(action)
      @action = action
      @responses = []
      @query_parameters = []
    end

  end
end
