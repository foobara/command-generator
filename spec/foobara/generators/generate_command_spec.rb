RSpec.describe Foobara::Generators::CommandGenerator::GenerateCommand do
  let(:name) { "SomeOrg::SomeDomain::SomeCommand" }

  let(:inputs) do
    {
      name:,
      description: "whatever"
    }
  end
  let(:command) { described_class.new(inputs) }
  let(:outcome) { command.run }
  let(:result) { outcome.result }

  it "generates a command" do
    expect(outcome).to be_success

    command_file = result["src/some_org/some_domain/some_command.rb"]
    expect(command_file).to include("module SomeOrg")
    expect(command_file).to include("module SomeDomain")
    expect(command_file).to include("class SomeCommand")

    expect(command.command_config.command_name).to eq("SomeCommand")
    expect(command.command_config.full_module_path).to eq(%w[SomeOrg SomeDomain SomeCommand])
  end

  context "with all options" do
    let(:inputs) do
      {
        name: "SomeCommand",
        description: "whatever",
        organization_name: "SomeOrg",
        domain_name: "SomeDomain"
      }
    end

    it "generates a command using the given options" do
      expect(outcome).to be_success

      command_file = result["src/some_org/some_domain/some_command.rb"]
      expect(command_file).to include("module SomeOrg")
      expect(command_file).to include("module SomeDomain")
      expect(command_file).to include("class SomeCommand")
    end
  end
end
