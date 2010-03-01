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
#     StructuredObject.new.should be_false
  end

  it "should return the correct structured when dumped" do
    @so.dump.should be_an_instance_of Hash
    @so.database.dump.should be_an_instance_of Hash
    @so.favorite_sites.should be_an_instance_of Array
  end
end
