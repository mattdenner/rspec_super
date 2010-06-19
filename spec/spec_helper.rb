require 'rspec_super'

class Base
  def do_something
    raise StandardError, "Nope, that code didn't work"
  end

  def do_something_with_arguments(a, b)
    raise StandardError, "Nope, that code didn't work"
  end

  def do_something_with_block(&block)
    yield
  end
end

class Intermediary < Base

end
