$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "atom_model/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "atom_model"
  s.version     = AtomModel::VERSION
  s.authors     = ["xiaohui"]
  s.email       = ["xiaohui@zhangxh.net"]
  s.homepage    = "http://github.com/xiaohui-zhangxh/atom_model"
  s.summary     = "Summary of AtomModel."
  s.description = "Description of AtomModel."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.1"

  s.add_development_dependency "pg"
end
