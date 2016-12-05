Gem::Specification.new do |s|
  s.version     = "1.0.0"
  s.name        = "youmagine-api-client"
  s.summary     = ""
  s.date        = "2016-12-05"
  s.description = "A wrapper around the YouMagine 3D model repository"
  s.authors     = ["Martijn Versluis", "Jordy Schreuders"]
  s.email       = "team@youmagine.com"
  s.files       = `git ls-files`.split("\n").reject { |f| f.match %r{^(spec)/} }
  s.homepage    = "https://youmagine.com"
  s.license     = "MIT"

  s.add_runtime_dependency "httparty", "~> 0.14.0"
end
