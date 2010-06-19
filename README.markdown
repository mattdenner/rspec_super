RSpec Super
===========
This gem provides [RSpec|http://rspec.info/] with a way for testing methods that call super.  Consider this:

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

How do you go about testing Derived#do_something without having to duplicate your Base#do_something tests?

With RSpec Super you get this:

  describe Derived do
    before(:each) do
      @object = described_class.new
    end

    describe '#do_something' do
      will_be_calling_super_on(:object) do
        it 'calls do something_else'
          super_should_be_called.with(no_args).once
          @object.should_receive(:do_something_else)
          @object.do_something
        end
      end
    end
  end

