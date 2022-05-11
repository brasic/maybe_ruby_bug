# frozen_string_literal: true
module BareSuperMemoizer
  def foo(arg1)
    @_memoized_foo ||= Hash.new { |h, k| h[k] = super }
    @_memoized_foo[arg1]
  end
end

module SuperWithParensMemoizer
  def foo(arg1)
    @_memoized_foo ||= Hash.new { |h, k| h[k] = super(k) }
    @_memoized_foo[arg1]
  end
end

class ExampleOne
  prepend BareSuperMemoizer
  attr_reader :calls

  def initialize
    @calls = Hash.new { |h, k| h[k] = 0 }
  end

  def foo(arg1)
    @calls[arg1] += 1
    arg1
  end
end

class ExampleTwo
  prepend SuperWithParensMemoizer
  attr_reader :calls

  def initialize
    @calls = Hash.new { |h, k| h[k] = 0 }
  end

  def foo(arg1)
    @calls[arg1] += 1
    arg1
  end
end

one = ExampleOne.new
puts one.foo(1)   # => 1
puts one.foo(:a)  # => 1
puts one.foo(1)   # => 1
puts one.foo(:a)  # => 1
puts one.calls    # => {1=>2}

two = ExampleTwo.new
puts two.foo(1)   # => 1
puts two.foo(:a)  # => :a
puts two.foo(1)   # => 1
puts two.foo(:a)  # => :a
puts two.calls    # => {1=>1, :a=>1}
