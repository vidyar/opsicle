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

# Stack Monitor classes
require "opsicle/monitor/app"
require "opsicle/monitor/panel"
require "opsicle/monitor/subpanel"
require "opsicle/monitor/screen"
require "opsicle/monitor/translatable"

require "opsicle/monitor/panels/deployments"
require "opsicle/monitor/panels/header"
