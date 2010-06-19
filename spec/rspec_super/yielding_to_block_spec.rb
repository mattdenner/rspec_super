require 'spec_helper'

class YieldingToBlock < Base
  def do_something_with_block(&block)
    super
    do_something_else_with_block(&block)
  end

  def do_something_else_with_block(&block)
    block.call
  end
end

describe YieldingToBlock do
  before(:each) do
    @object = described_class.new
  end

  describe '#do_something_with_block' do
    extend RSpecSuper

    it 'causes two callbacks by default' do
      callback = mock('callback')
      callback.should_receive(:called).twice

      @object.do_something_with_block { callback.called }
    end

    will_be_calling_super_on(:object) do
      it 'causes two callbacks with super' do
        callback = mock('callback')
        callback.should_receive(:called).twice

        super_should_be_called.once.and_yield
        @object.should_receive(:do_something_else_with_block).and_yield
        @object.do_something_with_block { callback.called }
      end
    end
  end
end
