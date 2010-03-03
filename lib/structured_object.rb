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
  include Enumerable, Comparable

  VERSION = '0.0.4'

  def new_ostruct_member(name)
    name = name.to_sym
    unless self.respond_to?(name)
      class << self; self; end.class_eval do
        define_method(name) do 
          case @table[name]
          when Hash
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

  # each: performs an 'each' iteration appropriate to the node (Hash, Array,
  # etc.)
  def each(&block)
    raise unless @table.respond_to?("each")

    @table.each &block
  end

  def ==(other)
    return false unless(other.kind_of?(StructuredObject))
    return @table == other.table
  end

  def <=>(other)
    other_table = other.dump

    raise NoMethodError, "Object to be compared against must be of type StructuredObject" unless other.kind_of? StructuredObject
    raise RuntimeError, "Node and Object to be compared against must resolve to 'Comparable' objects." unless @table.class.include?(Comparable) && other_table.class.include?(Comparable)

    return @table <=> other_table
  end

#   def method_missing
# if dumped class has the method, use that. Otherwise,
# super
#   end
end
