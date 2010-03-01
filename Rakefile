$:.unshift File.expand_path("../lib", __FILE__)

require 'rubygems'
require 'lib/structured_object'
require 'rake/gempackagetask'
 
lib_dir = File.expand_path('lib')
test_dir = File.expand_path('test')

gem_spec = Gem::Specification.new do |s|
  s.name = "structured_object"
  s.version = StructuredObject::VERSION
  s.authors = ["Samuel Mullen"]
  s.email = "samullen@gmail.com"
  s.homepage = "http://github.com/samullen/structured_object"
  s.summary = "A subclass of OpenStruct to allow nested elements"
  s.authors = ["Samuel Mullen"]
  s.email = "samullen@gmail.com"
  s.description = false
  s.files = [
    "LICENSE",
    "README.rdoc",
    "Rakefile",
#     "examples/functional.rb",
#     "examples/objectoriented.rb",
    "lib/structured_object.rb"
  ] + s.test_files
end

begin
  require 'spec/rake/spectask'
rescue LoadError
  task :spec do
    $stderr.puts '`gem install rspec` to run specs'
  end
else
  desc "Run specs"
  Spec::Rake::SpecTask.new do |t|
    t.spec_files = FileList['spec/**/*_spec.rb']
    t.spec_opts  = %w(-fs --color)
    t.warning    = true
  end
end

Rake::GemPackageTask.new(gem_spec) do |pkg|
  pkg.need_zip = false
  pkg.need_tar = false
end

desc "Install the gem locally"
task :install => [:spec, :gem] do
  sh %{gem install pkg/#{gem_spec.name}-#{gem_spec.version}}
end

desc "Remove the pkg directory and all of its contents."
task :clean => :clobber_package

task :default => [:spec, :gem]
