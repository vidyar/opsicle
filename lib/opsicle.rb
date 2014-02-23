Signal.trap("INT") do
  puts ""
  puts "Exiting..."
  exit 1
end

require "opsicle/version"

# Command classes
require "opsicle/commands/deploy"
require "opsicle/commands/list"
require "opsicle/commands/ssh"
require "opsicle/commands/ssh_key"
require "opsicle/commands/deployments"

