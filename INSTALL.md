# Installing Flight Cloud Client

## Generic

Flight Cloud Client requires a recent version of `ruby` (>=2.5.1) and `bundler`.
The following will install from source using `git`:

```
git clone https://github.com/openflighthpc/flight-cloud-client.git
cd flight-cloud-client
bundle install
```

The entry script is located at `bin/cloud`

## Installing with Flight Runway

Flight Runway provides the Ruby environment and command-line helpers for running openflightHPC tools.

To install Flight Runway, see the [Flight Runway installation docs](https://github.com/openflighthpc/flight-runway#installation).

These instructions assume that `flight-runway` has been installed from the openflightHPC yum repository and [system-wide integration](https://github.com/openflighthpc/flight-runway#system-wide-integration) enabled.

Install Flight Cloud Client

```
[root@myhost ~]# yum -y install flight-cloud-client
```

Flight Cloud Client is now available via the `flight` tool:

```
[root@myhost ~]# flight cloud
  NAME:

    cloud

  DESCRIPTION:

    Cloud orchestration tool

  COMMANDS:

    help  Display global or [command] help documentation
    list  Return a list of nodes and the domain
    power Check and manage the power state of nodes
```
