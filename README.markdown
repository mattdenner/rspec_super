RSpec Super
===========
This gem provides [RSpec](http://rspec.info/) with a way for testing methods that call super.  Consider this:

    class Base
      def do_something
      end
    end
    
    class Derived < Base
      def do_something
        super
        do_something_else
      end
    
      def do_something_else
      end
    end

How do you go about testing `Derived#do_something` without having to duplicate your `Base#do_something` tests?

With this gem you can use {Spec::Mocks::Methods#should_receive_super_of should_receive_super_of} and the standard RSpec expectations, just like this:

    describe Derived do
      before(:each) do
        @object = described_class.new
      end
    
      describe '#do_something' do
        it 'calls super' do
          @object.should_receive_super_of(:do_something).once
          @object.should_receive(:do_something_else).once
          @object.do_something
        end
      end
    end

