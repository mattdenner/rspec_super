require 'spec_helper'

class DirectlyDerived < Base
  def do_something
    super
    do_something_else
  end

  def do_something_else

  end
end

describe DirectlyDerived do
  before(:each) do
    @object = described_class.new
  end

  describe '#do_something' do
    extend RSpecSuper

    it 'raises without the super hook' do
      lambda { @object.do_something }.should raise_error(StandardError, "Nope, that code didn't work")
    end

    will_be_calling_super_on(:object) do
      it 'calls do_something_else' do
        super_should_be_called.once
        @object.should_receive(:do_something_else).once
        @object.do_something
      end
    end
  end
end
