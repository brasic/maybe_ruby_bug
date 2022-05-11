module Patch
  def foo(a)
    puts "outside super is #{super}"
    @h ||= Hash.new { |h, k| res = super; puts "inside super is #{res}"; h[k] = res }
    retval = @h[a]
    puts "outside again, super is #{super}\n\n"
    retval
  end
end

class Demo
  prepend Patch

  def foo(a)
    a
  end
end

demo = Demo.new

demo.foo(:first)
demo.foo(:second)
demo.foo(:third)
