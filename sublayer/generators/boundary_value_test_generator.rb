# frozen_string_literal: true

require "sublayer"

module Sublayer
  module Generators
    class BoundaryValueTestGenerator < Base
      llm_output_adapter type: :single_string,
                         name: "boundary_value_tests",
                         description: "The generated boundary-value tests for a given function."

      def initialize(function:, test_variation:, test_framework:)
        @function = function
        @test_variation = test_variation
        @test_framework = test_framework
      end

      def generate
        super
      end

      def prompt
        <<-PROMPT
You are an expert programmer in #{@test_framework} and boundary-value analysis.

You are tasked with writing unit tests using boundary-value analysis for the function below:
```ruby
#{@function}
````

#{@test_variation}

Take a deep breath and think step by step before you start coding.

Remember boundary-value analysis works well when the program to be tested is a function of several independent variables that represent bounded physical quantities. If you believe the given function is not a good candidate for boundary value analysis, you can instead suggest an alternative testing strategy.
        PROMPT
      end
    end
  end
end
