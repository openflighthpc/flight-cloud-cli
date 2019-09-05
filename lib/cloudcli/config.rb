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

require 'flight_config'

module CloudCLI
  class Config
    include FlightConfig::Reader
    allow_missing_read

    def self.root_path
      File.expand_path(File.join(__dir__, '..', '..'))
    end

    # TODO: Investigate why their needs to be an argument
    def self.path(*_)
      File.join(root_path, 'etc', 'config.yaml')
    end

    def self.cache
      @cache ||= read
    end

    def self.method_missing(s, *a, &b)
      if respond_if_missing?(s) == :config_method
        cache.public_send(s, *a, &b)
      else
        super
      end
    end

    def self.respond_if_missing?(s)
      cache.respond_to?(s) ? :config_method : super
    end

    def ip
      __data__.fetch(:ip) do
        raise StandardError, 'The cloud server ip has not been set'
      end
    end

    def port
      __data__.fetch(:port) { 443 }
    end

    def ca_path
      __data__.fetch(:ca_path) do
        raise StandardError, "The 'ca_path' has not been set within the config"
      end
    end

    def appname
      'cloud'
    end
  end
end
