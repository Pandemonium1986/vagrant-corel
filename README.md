# Vagrant Corel

[![Vagrant Cloud](https://img.shields.io/badge/vagrant-corel-lightgrey.svg)](https://app.vagrantup.com/pandemonium/)
![](https://img.shields.io/github/release/Pandemonium1986/vagrant-corel.svg)
![](https://img.shields.io/github/repo-size/Pandemonium1986/vagrant-corel.svg)
![](https://img.shields.io/github/release-date/Pandemonium1986/vagrant-corel.svg)
![](https://img.shields.io/github/license/Pandemonium1986/vagrant-corel.svg)

Collection of virtual machines containing tools for lab, study or demonstration purposes.

## Getting Started

This project build two virtualbox vms from [centos/8](https://app.vagrantup.com/centos/boxes/8).  
Both boxes are provided with ansible. Allowing to deploy all the tools I use for lab, study or demonstration.

**Awx**  

> AWX provides a web-based user interface, REST API, and task engine built on top of Ansible. It is the upstream project for Tower, a commercial derivative of AWX.

**Prometheus**  

> Prometheus, a Cloud Native Computing Foundation project, is a systems and service monitoring system. It collects metrics from configured targets at given intervals, evaluates rule expressions, displays the results, and can trigger alerts if some condition is observed to be true.

**Prometheus**  

> Grafana allows you to query, visualize, alert on and understand your metrics no matter where they are stored.

### Prerequisites

The following software are required to build the boxes :

-   [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) - The provisioner.
-   [Vagrant](https://www.vagrantup.com/downloads.html) - To build and manage the box.
-   [VirtualBox](https://www.virtualbox.org/wiki/Downloads) - The only provider available.

## Building

If you want to build the boxes, you need to clone the git repository and be sure to have ansible, virtualbox and vagrant installed.

```sh
git clone https://github.com/Pandemonium1986/vagrant-corel.git ~/git/Pandemonium1986/vagrant-corel
cd ~/git/Pandemonium1986/vagrant-corel
vagrant up
```

Or if you want to choose between the boxes.

```sh
git clone https://github.com/Pandemonium1986/vagrant-corel.git ~/git/Pandemonium1986/vagrant-corel
cd ~/git/Pandemonium1986/vagrant-corel
vagrant up corel[-awx|-obs]-cts
```

## Provisioning

If you wish to provision the box at startup

```sh
vagrant up corel[-awx|-obs]-cts --provision
```

If you want to provision the box after startup

```sh
vagrant provision corel[-awx|-obs]-cts
```

## Tools and boxes

| Tools      | Box           | Url                                                 | Login/Password |
| :--------- | :------------ | :-------------------------------------------------- | :------------- |
| Awx        | corel-awx-cts | [http://awx.lan](http://192.168.66.100)             | admin/password |
| Grafana    | corel-obs-cts | [http://grafana.lan](http://192.168.66.101:9090)    | admin/admin    |
| Prometheus | corel-obs-cts | [http://prometheus.lan](http://192.168.66.101:3000) | -              |

### Awx

He configure awx with :

-   Create a few organizations.
-   Add Alice, Bob, Charlie into redhat organization.
-   Create corel-awx-cts and corel-obs-cts hosts.
-   Create redhat-inventory with the previous hosts.
-   Create redhat ssh-key to access previous hosts.

### Grafana

He configure grafana with :

-   Configure admin password.
-   Create datasource prometheus.
-   Import metrics-server and metrics-tower dashboards.

### Prometheus

He configure prometheus with :

-   Create scraping jobs prometheus, server, tower

## Built With

-   [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) - The provisioner.
-   [Vagrant](https://www.vagrantup.com/downloads.html) - To build and manage the box.
-   [VirtualBox](https://www.virtualbox.org/wiki/Downloads) - The only provider available.

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/Pandemonium1986/vagrant-corel/tags).

## Authors

-   **Michael Maffait** - _Initial work_ - [Pandemonium1986](https://github.com/Pandemonium1986)

See also the list of [contributors](https://github.com/Pandemonium1986/vagrant-corel/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details
