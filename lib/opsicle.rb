Signal.trap("INT") do
  puts ""
  puts "Exiting..."
  exit 1
end

require "opsicle/version"
require "opsicle/deploy"
require "opsicle/list"
require "opsicle/ssh"

