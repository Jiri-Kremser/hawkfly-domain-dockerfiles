# hawkfly-domain-dockerfiles

Docker images and docker-compose files for some basic scenarios in which the hawkular is used for monitoring the WildFly servers managed as a domain. You may want to use the simple CLI tool called [hawkinit](https://github.com/Jiri-Kremser/hawkinit) to spawn the containers.

[![Build Status](https://travis-ci.org/Jiri-Kremser/hawkinit.svg?branch=master)](https://travis-ci.org/Jiri-Kremser/hawkinit)

## Usage

1. choose a scenario

  `cd scenarios/1-host/mid-size`
1. run it
  `docker-compose up`
  
## Scenarios

#### default
This creates the domain mode consisting of two server groups and three servers, the third server isn't started automatically. This scenario is the default domain mode when running the domain.sh with the servers declared in the default `host.xml` and groups in the default `domain.xml`

#### simple
This scenario and the following ones drop the default groups (as described ^) and servers and creates a new ones. Simple scenario has one server group called `my-group` and one server called `s`. ([cli init script](https://github.com/Jiri-Kremser/hawkfly-domain-dockerfiles/blob/master/images/master/01-small-domain/init/01-create-domain.cli))

#### mid-size
There are three pre-created server groups called `group1-3` and one server in each group called `s1-3`. ([cli init script](https://github.com/Jiri-Kremser/hawkfly-domain-dockerfiles/blob/master/images/master/02-mid-size-domain/init/01-create-domain.cli))

#### ha
There is only one server group called `ha-group` and two servers called `s1` and `s2`. Servers run with the `ha` profile so they should be clustered if the auto-discovery went well. ([cli init script](https://github.com/Jiri-Kremser/hawkfly-domain-dockerfiles/blob/master/images/master/03-ha-domain/init/01-create-domain.cli))

#### mixed
This scenario has two server groups. Thi first one is the same as in the `ha` scenario, i.e. the two clustered servers and the second one is the `normal-group` that has the `default` profile and two servers in it. ([cli scripts](https://github.com/Jiri-Kremser/hawkfly-domain-dockerfiles/tree/master/images/master/04-mixed-domain/init)) 

### 1 host vs n hosts
The `1 host` directory spawns a WildFly running on one host with some pre-created stuff, while the `n host` directory runs one server as the domain controller (master) and n hosts as slaves. By default the n is 1, but it can be easily increased by `docker-compose scale hawkfly-domain-{scenario}-slave=n`. Slaves connect to master with predefined credentials and can create also additional servers. Example of creating the additional server is [here](https://github.com/Jiri-Kremser/hawkfly-domain-dockerfiles/blob/master/scenarios/n-hosts/simple/docker-compose.yml#L23). It says: create two servers that should be part of the `my-group` group. The server names are created automatically from the slave's hostname.
