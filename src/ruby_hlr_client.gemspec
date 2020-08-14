# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'ruby_hlr_client/config'

Gem::Specification.new do |s|
  s.name        = 'ruby_hlr_client'
  s.version     = HlrLookupsSDK::CLIENT_VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Velocity Made Good Ltd.']
  s.email       = ['service@hlr-lookups.com']
  s.homepage    = 'https://www.hlr-lookups.com'
  s.summary     = %q{HLR Lookups SDK. Obtain live mobile phone connectivity and portability data from network operators directly.}
  s.licenses    = ['Apache-2.0']
  s.required_ruby_version = '>= 2.0.0'

  s.add_runtime_dependency 'rest-client', '~> 2.1', '>= 2.1.0'
  s.add_runtime_dependency 'json', '~> 1.8', '>= 1.8.3'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']
end