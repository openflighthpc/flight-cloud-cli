# Flight Cloud Client

A remote client for interacting with [Flight Cloud](https://github.com/openflighthpc/flight-cloud)

## Overview

Flight Cloud Client provides a remote CLI for interacting with Flight Cloud. It allows the controlling of power states of nodes in a Flight Cloud cluster.

## Installation

See [INSTALL.md](INSTALL.md).

## Configuration

To configure the server to be used by the client, copy and update the config file.

```
# Copy example config
cp etc/config.yaml.example etc/config.yaml

# Update server details
## Set ip: to the IP of the cloud server
## Set port: to the port used by the cloud server
vim etc/config.yaml
```

## Operation

Once the server details have been configured, launch the command using the cloud script in the `bin` directory
```
bin/cloud 
```

### Listing Deployments

Show all deployed resources:
```
bin/cloud list
```

Show all configured deployments:
```
bin/cloud list --all
```

### Controlling Power

Check power status of a node
```
bin/cloud power NODENAME status
```

Turn off a node
```
bin/cloud power NODENAME off
```

Turn on a node
```
bin/cloud power NODENAME on
```

Note: Use the `-g` flag to treat NODENAME as a group name to perform power commands on multiple nodes at once.

# Contributing

Fork the project. Make your feature addition or bug fix. Send a pull
request. Bonus points for topic branches.

Read [CONTRIBUTING.md](CONTRIBUTING.md) for more details.

# Copyright and License

Eclipse Public License 2.0, see [LICENSE.txt](LICENSE.txt) for details.

Copyright (C) 2019-present Alces Flight Ltd.

This program and the accompanying materials are made available under
the terms of the Eclipse Public License 2.0 which is available at
[https://www.eclipse.org/legal/epl-2.0](https://www.eclipse.org/legal/epl-2.0),
or alternative license terms made available by Alces Flight Ltd -
please direct inquiries about licensing to
[licensing@alces-flight.com](mailto:licensing@alces-flight.com).

Flight Cloud Client is distributed in the hope that it will be
useful, but WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, EITHER
EXPRESS OR IMPLIED INCLUDING, WITHOUT LIMITATION, ANY WARRANTIES OR
CONDITIONS OF TITLE, NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR
A PARTICULAR PURPOSE. See the [Eclipse Public License 2.0](https://opensource.org/licenses/EPL-2.0) for more
details.
