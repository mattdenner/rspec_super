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
    it 'calls super' do
      @object.should_receive_super_of(:do_something).once
      @object.should_receive(:do_something_else).once
      @object.do_something
    end
  end
end
