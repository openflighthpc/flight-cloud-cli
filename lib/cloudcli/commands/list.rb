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

module CloudCLI
  module Commands
    class List
      attr_reader :all, :group

      def initialize
        require 'cloudcli/api'
      end

      def run!(all: false, group: nil)
        @all = all
        @group = group
        run
      end

      def run
        result = API.new(Config.ip, Config.port)
                    .public_send('list', group)
                    .body

        deployments = result[:running]
        deployments = deployments.merge(result[:offline]) if all

        unless deployments.empty?
          deployments.each do |deployment, attributes|
            groups = attributes[:groups]

            puts "\nDeployment: '#{deployment}'"
            puts "--------------------------------------------------------"
            puts "Status: #{attributes[:status]}"
            puts "Groups: #{groups}" unless groups.to_s.empty?
          end
        else
          puts "No running deployments. Use --all to view all deployments"
        end
      end

      def list_groups
        puts API.new(Config.ip, Config.port)
                .public_send('list_groups')
                .body
      end
    end
  end
end
