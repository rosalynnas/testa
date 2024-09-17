# frozen_string_literal: true

module Sublayer
  module Providers
    class OllamaLlama31
      def self.call(prompt:, output_adapter:)
        response = HTTParty.post(
          "http://localhost:11434/api/chat",
          body: {
            "model": 'llama3.1',
            "messages": [
              {
                "role": "user",
                "content": prompt
              }
            ],
            "format": "json",
            "stream": false,
            "tools": [
              {
                "type": "function",
                "function": {
                  "name": 'response',
                  "parameters": {
                    "type": "object",
                    "properties": output_adapter.format_properties,
                    "required": output_adapter.format_required
                  }
                }
              }
            ]
          }.to_json
        )

        message = response['message']

        raise "No function called" unless message["tool_calls"].length > 0

        function_body = message.dig("tool_calls", 0, "function", "arguments")
        function_body[output_adapter.name]
      end
    end
  end
end