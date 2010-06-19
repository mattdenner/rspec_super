class Object
  def metaclass
    class << self ; self ; end
  end
end

module RSpecSuper 
  def will_be_calling_super_on(instance_variable_name, &block)
    instance_variable_name          = ensure_proper_instance_variable_name(instance_variable_name)
    method_under_test               = retrieve_method_under_test
    method_under_test_with_super    = :"#{ method_under_test }_with_super"
    method_under_test_without_super = :"#{ method_under_test }_without_super" 

    context "expected to call super(#{ method_under_test })" do
      line_number = __LINE__ + 1
      eval(%Q{
        def instance_variable
          instance_variable_get(#{ instance_variable_name.inspect })
        end

        def with_instance_variable(&block)
          instance_variable.instance_eval(&block)
        end

        def super_should_be_called
          instance_variable.should_receive(#{ method_under_test_with_super.inspect })
        end
      }, binding, __FILE__, line_number)

      before(:each) do
        with_instance_variable do
          self.class.superclass.class_eval do
            line_number = __LINE__ + 1
            eval(%Q{
              def #{ method_under_test_with_super }(*args, &block)
                #{ method_under_test_with_super }(*args, &block)
              end
              alias_method(#{ method_under_test_without_super.inspect }, #{ method_under_test.inspect })
              alias_method(#{ method_under_test.inspect }, #{ method_under_test_with_super.inspect })
            }, binding, __FILE__, line_number)
          end

          metaclass.instance_eval do
            define_method(method_under_test_with_super) do |*args|
              raise StandardError, 'You did not expect the super call using super_should_be_called'
            end
          end
        end
      end

      after(:each) do
        with_instance_variable do
          self.class.superclass.instance_eval do
            alias_method(method_under_test, method_under_test_without_super)
            undef_method(method_under_test_without_super)
            undef_method(method_under_test_with_super)
          end
        end
      end

      instance_eval(&block)
    end
  end

private

  def ensure_proper_instance_variable_name(name)
    name = name.to_s
    name = "@#{ name }" unless name =~ /^@/
    name.to_sym
  end

  def retrieve_method_under_test
    method_name = description_parts.last
    return method_name.to_sym unless method_name =~ /^#(.+)$/
    $1.to_sym
  end
end
