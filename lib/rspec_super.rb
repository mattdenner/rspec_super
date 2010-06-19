require 'spec/mocks/methods'

module Spec
  module Mocks
    module Methods
      # Behaves like +should_receive+ except that it can be used to set expectations on the
      # method specified calling super.
      def should_receive_super_of(method)
        should_receive(install_super_hook_for(method))
      end

    private

      def rspec_reset_with_super
        rspec_reset_without_super
        uninstall_super_hooks
      end
      alias_method(:rspec_reset_without_super, :rspec_reset)
      alias_method(:rspec_reset, :rspec_reset_with_super)

      #--
      # Complete fudge to make sure that YARD doesn't display rspec_reset_with_super in the
      # documentation!
      #++
      public :rspec_reset

      def uninstall_super_hooks #:nodoc:
        @_super_hooks_installed ||= []
        @_super_hooks_installed.each do |method|
          method_with_super, method_without_super = :"#{ method }_with_super", :"#{ method }_without_super"

          self.class.superclass.instance_eval do
            alias_method(method, method_without_super)
            undef_method(method_without_super)
            undef_method(method_with_super)
          end
        end
      end

      def install_super_hook_for(method) #:nodoc:
        method_with_super, method_without_super = :"#{ method }_with_super", :"#{ method }_without_super"

        self.class.superclass.class_eval do
          line_number = __LINE__ + 1
          eval(%Q{
            def #{ method_with_super }(*args, &block)
              #{ method_with_super }(*args, &block)
            end
            alias_method(#{ method_without_super.inspect }, #{ method.inspect })
            alias_method(#{ method.inspect }, #{ method_with_super.inspect })
          }, binding, __FILE__, line_number)
        end

        @_super_hooks_installed ||= []
        @_super_hooks_installed.push(method)

        return method_with_super
      end
    end
  end
end

