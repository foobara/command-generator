require "English"

module Foobara
  module Generators
    module CommandGenerator
      class CommandConfig < Foobara::Model
        attributes do
          command_name :string, :required
          description :string, :allow_nil
          organization_name :string, :allow_nil
          domain_name :string, :allow_nil
        end

        def full_module_name
          @full_module_name ||= [*organization_name, *domain_name, command_name].join("::")
        end

        def module_path
          @module_path ||= full_module_name.split("::")
        end
      end
    end
  end
end
