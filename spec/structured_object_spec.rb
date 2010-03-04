require File.join(File.dirname(__FILE__), '..', 'lib','structured_object')

describe StructuredObject do
  before(:each) do
    @yaml = {
              "database"=>{
                "db_name"=>"main_database", 
                "host"=>"1.2.3.4", 
                "username"=>"jgalt", 
                "password"=>"Ai$A"
              }, 
              "mailer"=>{
                "from"=>"no-reply@phalanxit.com", 
                "subject"=>"Your daily propoganda",
                "to"=>"jgalt@phalanxit.com"
              }, 
              "favorite_sites"=>[
                "http://google.com",
                "http://lala.com",
                "http://delicious.com",
                "http://posterous.com",
              ]
            }
    @so = StructuredObject.new(@yaml)
  end

#   after(:all) do
#   end

#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=#

  it "should be able to add new nodes" do
    hash = {:a => 1, :b => 2, :c => 3}
    @so.foo = hash
    @so.foo.should be_an_instance_of StructuredObject
    @so.foo.dump.eql?(hash).should be_true
    @so.foo.a.should be 1

    array = (0..10).to_a
    @so.bar = array
    @so.bar.should be_an_instance_of Array
    @so.bar.eql?(array).should be_true
    @so.bar.first.should be 0
  end

  it "should return the correct structure when dumped" do
    @so.dump.should be_an_instance_of Hash
    @so.database.dump.should be_an_instance_of Hash
    @so.favorite_sites.should be_an_instance_of Array
    @so.favorite_sites.first.should be_an_instance_of String
  end

  it "should implement enumerable's methods" do
    lambda { @so.database.db_name.each }.should raise_error(NoMethodError)
    @so.favorite_sites.each.should be_an_instance_of Enumerator
    @so.each.should be_an_instance_of Enumerator
    @so.favorite_sites.collect {|x| x}.should == @yaml["favorite_sites"]
  end

  it "should accurately check for equality" do
    new_so = StructuredObject.new(@yaml)
    @so.should == new_so
    @so.database.should == new_so.database
    @so.favorite_sites.should == new_so.favorite_sites
    lambda { @so <=> "foo" }.should raise_error(NoMethodError)
    lambda { @so <=> new_so }.should raise_error(RuntimeError)
    @so.database.db_name.should < "zzz"
  end

  it "should try to call missing methods on the super class first" do
# puts @so.database.db_name > "xxx"
#     @so.keys = [:a, :b, :c]
#     puts @so.keys
#     @so.merge!({:host => "172.0.0.1", :domain => "phalanxit.com"})
# puts    @so.dump.keys
  end
end
