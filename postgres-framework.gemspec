Gem::Specification.new do |s|
  s.name              = 'postgres-framework'
  s.version           = File.open('VERSION') {|f| f.readline}
  s.license           = 'BSD-4-Clause'
  s.author            = 'Rafał Mikołajun'
  s.summary           = 'PostgreSQL Framework'
  s.description       = 'It\'s simple framework for PostgreSQL database with unit tests and versioning.'
  s.homepage          = 'https://github.com/mikoweb/postgres-framework'
  s.files             = %w[.gitmodules LICENSE README.md]
  s.files             += Dir.glob('bin/**/*')
  s.files             += Dir.glob('plpgunit/**/*')
  s.files             += Dir.glob('scripts/**/*')
  s.files             += Dir.glob('src/**/*')
  s.files             += Dir.glob('tests/**/*')
  s.executables       = Dir.entries('bin').select {|f| !File.directory? f}
end
