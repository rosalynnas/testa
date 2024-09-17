require "sublayer"
require "./sublayer/providers/ollama_llama_3_1"
require "./sublayer/generators/boundary_value_test_generator"

Sublayer.configuration.ai_provider = Sublayer::Providers::OllamaLlama31

basic_variation = <<-BASIC_VARIATION
Basic boundary-value analysis testing:
- The tests should use input variable values at their minimum, just above the minimum, a nominal value, just below their maximum, and at their maximum.
- There is no need to test values below the minimum or above the maximum.
- You may make the single fault assumption of reliability theory and hold the values of all but one variable at their nominal values, and letting that variable assume its full set of test values.

Notes:
- Remember for a function of n variables, boundary value analysis yields 4n + 1 unique test cases.
- When no explicit bounds are present, assume logical minimum and maximum values based on the the data type.
- Accepting the single-fault assumption means that we are only interested in what happens when one variable has an extreme value.
BASIC_VARIATION

robust_variation = <<-ROBUST_VARIATION
Robust boundary-value analysis testing:
- The tests should use input variable values at their minimum, just above the minimum, a nominal value, just below their maximum, and at their maximum.
- Test what happens when the extrema are exceeded with a value slightly greater than the maximum and a value slightly less than the minimum.
- You may accept the single-fault assumption and hold the values of all but one variable at their nominal values, and letting that variable assume its full set of test values.

Notes:
- Remember for a function of n variables, boundary value analysis yields 6n + 1 unique test cases.
- When no explicit bounds are present, assume logical minimum and maximum values based on the the data type.
- Accepting the single-fault assumption means that we are only interested in what happens when one variable has an extreme value.
- The main value of robustness testing is that it forces attention on exception handling.
ROBUST_VARIATION

function = <<-FUNCTION
def valid?(age)
  age >= 18
end
FUNCTION

test_framework = 'rspec'
test_variation = robust_variation

generator = Sublayer::Generators::BoundaryValueTestGenerator.new(function:, test_variation:, test_framework:)
puts generator.generate
