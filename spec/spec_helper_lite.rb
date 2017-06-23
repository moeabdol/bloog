require "rr"

# class MiniTest::Unit::TestCase
#   include RR::Adapters::MiniTest
# end

def stub_module(full_name)
  full_name.split(/::/).inject(Object) do |context, name|
    begin
      context.const_get(name)
    rescue
      context.const_set(name, Module.new)
    end
  end
end
