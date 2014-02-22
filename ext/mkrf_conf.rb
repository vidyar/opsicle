# This faux C extension is used to install the Ruby curses library *only* for Ruby >=2.1.0
# Curses was removed in 2.1.0 from stdlib, and it's resulting gem (https://github.com/ruby/curses)
# does NOT support <2.1.0.
# We want to ensure curses (and as a result, opsicle) is available for 1.9.3 - 2.1.0+

# This taken from @tiredpixel and his post on the subject:
# http://www.tiredpixel.com/2014/01/05/curses-conditional-ruby-gem-installation-within-a-gemspec/

require 'rubygems/dependency_installer'

di = Gem::DependencyInstaller.new

begin
  if RUBY_VERSION >= '2.1'
    puts "Installing curses gem because you're running Ruby #{RUBY_VERSION}"

    di.install "curses", "~> 1.0"
  else
    puts "Not installing curses gem because you're running Ruby #{RUBY_VERSION}"
  end
rescue => e
  warn "#{$0}: #{e}"

  exit!
end

# This is another step of using this method, but we don't need to as we use a Rakefile already.
# Keeping it here for future reference.

# puts "Writing fake Rakefile"

# # Write fake Rakefile for rake since Makefile isn't used
# File.open(File.join(File.dirname(__FILE__), 'Rakefile'), 'w') do |f|
#   f.write("task :default" + $/)
# end
