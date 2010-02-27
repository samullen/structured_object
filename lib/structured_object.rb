require 'ostruct'

#
# = StructuredObject
#
# StructuredObject is a subclass of OpenStruct which allows the user to nest
# data structures as objects.
#
# require 'structured_object'
#
# x = {'a' => 1, 'b' => {'aa' => 11, 'bb' => 22'], 'c' => [0,1,2,3,4]}
#
# so = StructuredObject.new(x)
# so.a     # -> 1
# so.b     # -> #<StructuredObject aa=11, bb=22>
# so.c     # -> [0, 1, 2, 3, 4]
#
# so.name = "John Galt"
# so.teas = {:breakfast => "Tazo Passion", "afternoon" => 'Earl Grey'}
#
# so.name           # -> "John Galt"
# so.teas.breakfast # -> "Tazo Passion"
#
# For more information, see the OpenStruct documentation

class StructuredObject < OpenStruct
  VERSION = '0.0.1'

  def new_ostruct_member(name)
    name = name.to_sym
    unless self.respond_to?(name)
      class << self; self; end.class_eval do
        define_method(name) do 
          if @table[name].instance_of? Hash
            StructuredObject.new(@table[name])
          else
            @table[name]
          end
        end
        define_method(:"#{name}=") { |x| @table[name] = x }
      end
    end
  end

  # dump: alias of the mashal_dump method in OpenStruct, returns the raw data
  # structure
  alias dump marshal_dump
end