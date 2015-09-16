Gem::Specification.new do |s|

  s.name            = 'logstash-output-arangodb'
  s.version         = '0.1.0'
  s.licenses        = ['Apache License (2.0)']
  s.summary         = "Logstash Output to ArangoDB"
  s.description     = "Output events to ArangoDB"
  s.authors         = ["Pere Urbon-Bayes"]
  s.email           = 'pere.urbon@gmail.com'
  s.homepage        = "http://purbon.com/"
  s.require_paths = ["lib"]

  # Files
  s.files = `git ls-files`.split($\)

  # Tests
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  # Special flag to let us know this is actually a logstash plugin
  s.metadata = { "logstash_plugin" => "true", "logstash_group" => "output" }

  s.add_runtime_dependency 'logstash-core', '>= 1.4.0', '< 2.0.0'
  s.add_runtime_dependency 'ashikawa-core', '~> 0.14.0'
  s.add_runtime_dependency 'stud', ['>= 0.0.17', '~> 0.0']

  s.add_development_dependency 'logstash-devutils'
  s.add_development_dependency 'logstash-codec-plain'

end
