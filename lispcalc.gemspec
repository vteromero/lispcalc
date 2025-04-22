require_relative 'lib/lispcalc/version'

Gem::Specification.new do |s|
  s.name         = 'lispcalc'
  s.version      = Lispcalc::VERSION
  s.authors      = ['Vicente Romero']
  s.email        = 'vteromero@gmail.com'

  s.summary      = 'Lisp-like calculator interpreter'
  s.homepage     = 'https://github.com/vteromero/lispcalc'
  s.license      = 'MIT'

  s.required_ruby_version = '>= 2.7.0'

  s.files        = Dir['lib/**/*', 'LICENSE', 'README.md']
  s.require_path = 'lib'

  s.add_dependency 'bigdecimal'

  s.add_development_dependency 'minitest', '~> 5.0'
  s.add_development_dependency 'rake'
end
