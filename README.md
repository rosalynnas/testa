# Testa

Testa is a POC for generating unit-level tests with sublayer. It facilitates writing tests for developers who are already familiar with specification-based testing approaches, while also teaching developers who are new to them.

Specifically, this tool will help you
- Determine the preferred testing approach for a given program
- Calculate the input and output domains of a program
- Write tests that cover all possible outcomes of a program

For now, this project is a just a proof of concept so there is only one supported testing approach. If it works well, more will come.

## Installation

The development dependencies are:

* [asdf](https://github.com/asdf-vm/asdf) 0.14.0
* [asdf-ruby](https://github.com/asdf-vm/asdf-ruby.git ) 1.10.0
* [ruby](https://www.ruby-lang.org/en/) 3.3.4
* [bundler](https://bundler.io) 2.5.18

Once you've installed those, you can install the project dependencies:
```bash
bundle install
```

You will also need to download [Ollama](https://ollama.com) and install the CLI tools. Then you can run the LLM locally:

```bash
ollama run llama3.1
```

## Boundary value testing

This technique is relevant when the program is a function of independent variables that represent bounded physical quantities.

To generate boundary value tests for a given file, run
```bash
ruby "generate_boundary_value_tests.rb”
```

### Testing considerations
- Normal (testing the extreme values of a single input)
- Robust (testing valid and invalid inputs)

### Single-fault assumption
Assumes that faults are due to incorrect values of a single variable.

### Testing variations
- Normal boundary value testing (preferred when invalid input is unlikely)
- Robust boundary value testing (preferred when invalid input is likely)
- Worst-case boundary value testing (preferred when physical variables have numerous interactions)
- Robust worst-case boundary value testing (preferred when the failure of the function is extremely costly)

