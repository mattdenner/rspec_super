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
    it 'calls super with arguments' do
      @object.should_receive_super_of(:do_something_with_arguments).with(1, 2).once
      @object.should_receive(:do_something_else_with_arguments).with(1, 2).once
      @object.do_something_with_arguments(1, 2)
    end
  end
end

