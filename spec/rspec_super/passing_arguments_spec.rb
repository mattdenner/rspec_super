require 'spec_helper'

class PassingArguments < Base
  def do_something_with_arguments(a, b)
    super
    do_something_else_with_arguments(a, b)
  end

  def do_something_else_with_arguments(a, b)
  end
end

describe PassingArguments do
  before(:each) do
    @object = described_class.new
  end

  describe '#do_something_with_arguments' do
    extend RSpecSuper

    will_be_calling_super_on(:object) do
      it 'calls do_something_else_with_arguments' do
        super_should_be_called.with(1, 2).once
        @object.should_receive(:do_something_else_with_arguments).with(1, 2).once
        @object.do_something_with_arguments(1, 2)
      end
    end
  end
end

