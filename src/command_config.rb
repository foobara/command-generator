require "English"

module Foobara
  module Generators
    module CommandGenerator
      class CommandConfig < Foobara::Model
        attributes do
          name :string, :required
          description :string, :allow_nil
          organization_name :string, :allow_nil
          domain_name :string, :allow_nil
          no_organization :boolean, default: false
          no_domain :boolean, default: false
          top_level :boolean, default: false, description: "Puts A::B::C in src/c.rb instead of src/a/b/c.rb"
        end

        attr_accessor :command_path, :full_module_name, :original_attributes

        def initialize(...)
          super
          update_names
        end

        def module_path
          @module_path ||= full_module_name.split("::")
        end

        def command_name
          @command_name ||= command_path.join("::")
        end

        def full_module_path
          @full_module_path ||= full_module_name.split("::")
        end

        private

        def update_names
          return if @names_updated

          self.original_attributes = Util.deep_dup(attributes)

          org, *dom_command_parts = name.split("::")

          if !no_organization && organization_name.nil?
            write_attribute(:organization_name, org)
          else
            dom_command_parts = [org, *dom_command_parts]
          end

          dom, *command_parts = dom_command_parts

          if !no_domain && domain_name.nil?
            write_attribute(:domain_name, dom)
          else
            command_parts = [dom, *command_parts]
          end

          self.command_path = command_parts
          self.full_module_name = [*organization_name, *domain_name, *command_parts].join("::")

          @names_updated = true
        end
      end
    end
  end
end
