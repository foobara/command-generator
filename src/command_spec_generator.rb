require_relative "command_generator"

module Foobara
  module Generators
    module CommandGenerator
      module Generators
        class CommandSpecGenerator < CommandGenerator
          def template_path
            ["spec", "command_spec.rb.erb"]
          end

          def target_path
            *path, file = module_path.map { |part| Util.underscore(part) }

            file = "#{file}_spec.rb"

            ["spec", *path, file]
          end
        end
      end
    end
  end
end
