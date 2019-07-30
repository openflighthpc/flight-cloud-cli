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

require 'faraday'
require 'hashie'
require 'faraday_middleware'

module CloudCLI
  API = Struct.new(:ip, :port) do
    def power_status(node, group: false)
      connection.get("/power/#{node}", group: group)
    end

    def power_on(node, group: false)
      connection.get("/power/#{node}/on", group: group)
    end

    def power_off(node, group: false)
      connection.get("/power/#{node}/off", group: group)
    end

    def list(group)
      connection.get("/list", group: group)
    end

    private

    def url
      "http://#{ip}:#{port}"
    end

    def connection
      @connection ||= Faraday::Connection.new(url) do |con|
        con.request :url_encoded
        con.use FaradayMiddleware::Mashify
        con.response :json, content_type: /\bjson$/
        con.adapter Faraday.default_adapter
      end
    end
  end
end
