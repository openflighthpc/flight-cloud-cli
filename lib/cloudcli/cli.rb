# frozen_string_literal: true
#==============================================================================
# Copyright (C) 2019-present Alces Flight Ltd
#
# This file is part of flight-cloud-cli
#
# This program and the accompanying materials are made available under
# the terms of the Eclipse Public License 2.0 which is available at
# <https://www.eclipse.org/legal/epl-2.0>, or alternative license
# terms made available by Alces Flight Ltd - please direct inquiries
# about licensing to licensing@alces-flight.com.
#
# This project is distributed in the hope that it will be useful, but
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, EITHER EXPRESS OR
# IMPLIED INCLUDING, WITHOUT LIMITATION, ANY WARRANTIES OR CONDITIONS
# OF TITLE, NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A
# PARTICULAR PURPOSE. See the Eclipse Public License 2.0 for more
# details.
#
# You should have received a copy of the Eclipse Public License 2.0
# along with this project. If not, see:
#
#  https://opensource.org/licenses/EPL-2.0
#
# For more information on flight-account, please visit:
# https://github.com/openflighthpc/flight-cloud-cli
#===============================================================================

require 'commander'
require 'cloudcli/config'
require 'cloudcli/commands/power'
require 'cloudcli/commands/list'

module CloudCLI
  # TODO: Move me to a new file
  VERSION = '0.0.1'

  class CLI
    extend Commander::UI
    extend Commander::UI::AskForClass
    extend Commander::Delegates

    program :name, Config.appname
    program :version, CloudCLI::VERSION
    program :description, 'Cloud orchestration tool'
    program :help_paging, false

    silent_trace!

    def self.run!
      ARGV.push '--help' if ARGV.empty?
      super
    end

    def self.action(command, klass, method: :run!)
      command.action do |args, options|
        hash = options.__hash__
        hash.delete(:trace)
        begin
          begin
            cmd = klass.new
            if hash.empty?
              cmd.public_send(method, *args)
            else
              cmd.public_send(method, *args, **hash)
            end
          rescue Interrupt
            raise RuntimeError, 'Received Interrupt!'
          end
        rescue StandardError => e
          # TODO: Add logging
          # Log.fatal(e.message)
          raise e
        end
      end
    end

    def self.cli_syntax(command, args_str = '')
      command.hidden = true if command.name.split.length > 1
      command.syntax = <<~SYNTAX.chomp
        #{program(:name)} #{command.name} #{args_str} [options]
      SYNTAX
    end

    command('power') do |c|
      cli_syntax(c, 'NODE_IDENTIFIER COMMAND')
      c.summary = 'Check and manage the power state of nodes'
      c.description = <<~DESC
        Tool for checking and managing the power state of nodes in a cluster.

        The following COMMANDs are supported:
          on      - Turn on the node
          off     - Turn off the node
          status  - Check the power status of the node
          reset   - Turn a node off and back on again
      DESC
      c.option '-g', '--group', <<~OPT.chomp
        Run the command over a group of nodes given by NODE_IDENTIFIER
      OPT
      action(c, Commands::Power)
    end

    command('list') do |c|
      cli_syntax(c)
      c.summary = 'Return a list of nodes and the domain'
      c.option '-a', '--all', 'List all nodes and domains'
      c.option '-g GROUP', '--group GROUP', 'Filter the list by group'
      action(c, Commands::List)
    end

    command('list-groups') do |c|
      cli_syntax(c)
      c.description = 'List all groups within the cluster'
      action(c, Commands::List, method: :list_groups)
    end
  end
end
