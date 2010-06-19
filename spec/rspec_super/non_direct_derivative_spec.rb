require 'spec_helper'

class DerivedThroughIntermediary < Intermediary
  def do_something
    super
    do_something_else
  end

  def do_something_else
  end
end

describe DerivedThroughIntermediary do
  before(:each) do
    @object = described_class.new
  end

  describe '#do_something' do
    extend RSpecSuper

    will_be_calling_super_on(:object) do
      it 'calls do_something_else' do
        super_should_be_called.once
        @object.should_receive(:do_something_else).once
        @object.do_something
      end
    end
  end
end
