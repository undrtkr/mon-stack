# Dockerized Zabbix Server 5.0 Installation Script


This script, installs and configures a dockerized zabbix 5.0 server in a fully automated way on CentOS 7 platforms.

Here's the summary:

- Enables Epel repo.
- Installs docker (ce), docker compose and jq.
- Creates self signed SSL certificates for zabbix and grafana frontends.
- Deploys zabbix services via docker compose.
- Invokes the zabbix API to do following configurations.
    - Creates a bunch of hosts group.
    - Creates auto registration actions for Linux and Windows hosts.
    - Tune Linux / Windows Templates items: 
        - Set FS discovery interval 30m for linux template
        - Set network interface discovery interval 30m for linux template
        - Set total memory check interval 5m for linux template
        - Set total swap check interval 30m for linux template
        - Set Number of CPUs interval 30m for linux template.
        - Set FS discovery interval 30m for Windows template
        - Set network interface discovery interval 30m for Windows template
        - Add free memory usege as percent for Windows
        - Disable  annoying service discovery rules which creates too mant false positive alerts.
    - Adds alexanderzobnin-zabbix-app datasource plugin to grafana.
    - Adds briangann-gauge-panel, btplc-trend-box-panel and jdbranham-diagram-panel plugins to grafana.
    - Invokes the grafana API to add custom Linux / Windows dashboards as well as Zabbix overall system status dashboard.
    - Sets email notification for admin user. (Optional)
    - Sets slack notification for admin user. (Optional)
    - Changes the default notification messages in a more informative manner.

## Usage

To invoke zabbix server installation, execute the "zabbix-server" script with "init" parameter and follow the instructions.

```
# bash scripts/zabbix-server.sh init
```

You can find an complete example output at the end of the page.

## Accessing Zabbix and Grafana UIs

Zabbix ui is accessible on port 8443 with the credentials listed below:

```
URL: https://host-ip:8443
Username: Admin
Password: zabbix
```

and grafana is on port 3000:

```
URL: https://host-ip:3000
Username: admin
Password: zabbix
```

Note: Both services are served over https by using a self-signed certificate.

## Screenshots

### Insight Panel:
![alt text](https://bitbucket.org/secopstech/zabbix-server/raw/9b33457148fe7dcc761206653571419e35bfeb2b/screenshots/linux-insight.png "Insight")

### CPU and Memory Graphs
![alt text](https://bitbucket.org/secopstech/zabbix-server/raw/9b33457148fe7dcc761206653571419e35bfeb2b/screenshots/linux-cpu-mem.png "CPU and Memory Graphs")

### Filesystem and Network Interfaces Graphs
![alt text](https://bitbucket.org/secopstech/zabbix-server/raw/9b33457148fe7dcc761206653571419e35bfeb2b/screenshots/linux-fs-netif.png "Filesystem and Network Interfaces Graph")

### Overall system status dashboard
![alt text](https://bitbucket.org/secopstech/zabbix-server/raw/9b33457148fe7dcc761206653571419e35bfeb2b/screenshots/overall-system-status.png "Overall system status")

### Example slack alerts
![alt text](https://bitbucket.org/secopstech/zabbix-server/raw/9b33457148fe7dcc761206653571419e35bfeb2b/screenshots/slack-notification.png "Slack notification")


## Example output

```
# bash scripts/zabbix-server.sh init

DOCKERIZED ZABBIX DEPLOYMENT AND CONFIGURATION SCRIPT
Version: 2.0.0

By this script, the steps listed below will be done:

- Latest Docker(CE) engine and docker-compose installation.
- Dockerized zabbix server deployment by using the official zabbix docker images and compose file.
- Required packages installation like epel-repo and jq.
- Creating auto registration actions for Linux & Windows hosts.
- Creating some additional check items/triggers for Linux & Windows templates.
- Grafana integration and deployment of some useful custom dashboards.
- SMTP settings and admin email configurations. (Optional)
- Slack integration. (Optional)

NOTE: Any deployed zabbix server containers will be taken down and re-created.
 Do you want to continue (Yes or No):  yes
Continue...

- Install dependencies.
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
 * base: mirror.niobeweb.net
 * extras: mirror.fibersunucu.com.tr
 * updates: denizli.centos-mirror.guzel.net.tr
base                                                                                                                                                                                 | 3.6 kB  00:00:00
extras                                                                                                                                                                               | 2.9 kB  00:00:00
updates                                                                                                                                                                              | 2.9 kB  00:00:00
Resolving Dependencies
--> Running transaction check
---> Package epel-release.noarch 0:7-11 will be installed
--> Finished Dependency Resolution

Dependencies Resolved

============================================================================================================================================================================================================
 Package                                               Arch                                            Version                                        Repository                                       Size
============================================================================================================================================================================================================
Installing:
 epel-release                                          noarch                                          7-11                                           extras                                           15 k

Transaction Summary
============================================================================================================================================================================================================
Install  1 Package

Total download size: 15 k
Installed size: 24 k
Downloading packages:
epel-release-7-11.noarch.rpm                                                                                                                                                         |  15 kB  00:00:05
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Installing : epel-release-7-11.noarch                                                                                                                                                                 1/1
  Verifying  : epel-release-7-11.noarch                                                                                                                                                                 1/1

Installed:
  epel-release.noarch 0:7-11

Complete!
Enable epel repo:                               ==> done
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
epel/x86_64/metalink                                                                                                                                                                 |  18 kB  00:00:00
 * base: mirror.muvhost.com
 * epel: mirrors.n-ix.net
 * extras: mirror.muvhost.com
 * updates: denizli.centos-mirror.guzel.net.tr
epel                                                                                                                                                                                 | 4.7 kB  00:00:00
(1/3): epel/x86_64/group_gz                                                                                                                                                          |  95 kB  00:00:06
(2/3): epel/x86_64/updateinfo                                                                                                                                                        | 1.0 MB  00:00:06
(3/3): epel/x86_64/primary_db                                                                                                                                                        | 6.9 MB  00:00:11
Resolving Dependencies
--> Running transaction check
---> Package jq.x86_64 0:1.6-2.el7 will be installed
--> Processing Dependency: libonig.so.5()(64bit) for package: jq-1.6-2.el7.x86_64
--> Running transaction check
---> Package oniguruma.x86_64 0:6.8.2-1.el7 will be installed
--> Finished Dependency Resolution

Dependencies Resolved

============================================================================================================================================================================================================
 Package                                           Arch                                           Version                                                Repository                                    Size
============================================================================================================================================================================================================
Installing:
 jq                                                x86_64                                         1.6-2.el7                                              epel                                         167 k
Installing for dependencies:
 oniguruma                                         x86_64                                         6.8.2-1.el7                                            epel                                         181 k

Transaction Summary
============================================================================================================================================================================================================
Install  1 Package (+1 Dependent package)

Total download size: 348 k
Installed size: 1.0 M
Downloading packages:
warning: /var/cache/yum/x86_64/7/epel/packages/oniguruma-6.8.2-1.el7.x86_64.rpm: Header V3 RSA/SHA256 Signature, key ID 352c64e5: NOKEY                                   ]  0.0 B/s | 169 kB  --:--:-- ETA
Public key for oniguruma-6.8.2-1.el7.x86_64.rpm is not installed
(1/2): oniguruma-6.8.2-1.el7.x86_64.rpm                                                                                                                                              | 181 kB  00:00:06
(2/2): jq-1.6-2.el7.x86_64.rpm                                                                                                                                                       | 167 kB  00:00:06
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Total                                                                                                                                                                        51 kB/s | 348 kB  00:00:06
Retrieving key from file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
Importing GPG key 0x352C64E5:
 Userid     : "Fedora EPEL (7) <epel@fedoraproject.org>"
 Fingerprint: 91e9 7d7c 4a5e 96f1 7f3e 888f 6a2f aea2 352c 64e5
 Package    : epel-release-7-11.noarch (@extras)
 From       : /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Installing : oniguruma-6.8.2-1.el7.x86_64                                                                                                                                                             1/2
  Installing : jq-1.6-2.el7.x86_64                                                                                                                                                                      2/2
  Verifying  : oniguruma-6.8.2-1.el7.x86_64                                                                                                                                                             1/2
  Verifying  : jq-1.6-2.el7.x86_64                                                                                                                                                                      2/2

Installed:
  jq.x86_64 0:1.6-2.el7

Dependency Installed:
  oniguruma.x86_64 0:6.8.2-1.el7

Complete!
Install jq:                             ==> done
----------------------------------------------------------------
openssl is already installed:                   ==> skipped
----------------------------------------------------------------

- Install Docker CE.
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
 * base: mirror.niobeweb.net
 * epel: mirrors.coreix.net
 * extras: mirror.muvhost.com
 * updates: denizli.centos-mirror.guzel.net.tr
Package device-mapper-persistent-data-0.8.5-2.el7.x86_64 already installed and latest version
Package 7:lvm2-2.02.186-7.el7_8.2.x86_64 already installed and latest version
Resolving Dependencies
--> Running transaction check
---> Package yum-utils.noarch 0:1.1.31-54.el7_8 will be installed
--> Processing Dependency: python-kitchen for package: yum-utils-1.1.31-54.el7_8.noarch
--> Processing Dependency: libxml2-python for package: yum-utils-1.1.31-54.el7_8.noarch
--> Running transaction check
---> Package libxml2-python.x86_64 0:2.9.1-6.el7.4 will be installed
---> Package python-kitchen.noarch 0:1.1.1-5.el7 will be installed
--> Processing Dependency: python-chardet for package: python-kitchen-1.1.1-5.el7.noarch
--> Running transaction check
---> Package python-chardet.noarch 0:2.2.1-3.el7 will be installed
--> Finished Dependency Resolution

Dependencies Resolved

============================================================================================================================================================================================================
 Package                                             Arch                                        Version                                                 Repository                                    Size
============================================================================================================================================================================================================
Installing:
 yum-utils                                           noarch                                      1.1.31-54.el7_8                                         updates                                      122 k
Installing for dependencies:
 libxml2-python                                      x86_64                                      2.9.1-6.el7.4                                           base                                         247 k
 python-chardet                                      noarch                                      2.2.1-3.el7                                             base                                         227 k
 python-kitchen                                      noarch                                      1.1.1-5.el7                                             base                                         267 k

Transaction Summary
============================================================================================================================================================================================================
Install  1 Package (+3 Dependent packages)

Total download size: 862 k
Installed size: 4.3 M
Downloading packages:
(1/4): libxml2-python-2.9.1-6.el7.4.x86_64.rpm                                                                                                                                       | 247 kB  00:00:05
(2/4): python-chardet-2.2.1-3.el7.noarch.rpm                                                                                                                                         | 227 kB  00:00:05
(3/4): python-kitchen-1.1.1-5.el7.noarch.rpm                                                                                                                                         | 267 kB  00:00:00
(4/4): yum-utils-1.1.31-54.el7_8.noarch.rpm                                                                                                                                          | 122 kB  00:00:05
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Total                                                                                                                                                                        73 kB/s | 862 kB  00:00:11
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Installing : python-chardet-2.2.1-3.el7.noarch                                                                                                                                                        1/4
  Installing : python-kitchen-1.1.1-5.el7.noarch                                                                                                                                                        2/4
  Installing : libxml2-python-2.9.1-6.el7.4.x86_64                                                                                                                                                      3/4
  Installing : yum-utils-1.1.31-54.el7_8.noarch                                                                                                                                                         4/4
  Verifying  : libxml2-python-2.9.1-6.el7.4.x86_64                                                                                                                                                      1/4
  Verifying  : python-kitchen-1.1.1-5.el7.noarch                                                                                                                                                        2/4
  Verifying  : yum-utils-1.1.31-54.el7_8.noarch                                                                                                                                                         3/4
  Verifying  : python-chardet-2.2.1-3.el7.noarch                                                                                                                                                        4/4

Installed:
  yum-utils.noarch 0:1.1.31-54.el7_8

Dependency Installed:
  libxml2-python.x86_64 0:2.9.1-6.el7.4                                python-chardet.noarch 0:2.2.1-3.el7                                python-kitchen.noarch 0:1.1.1-5.el7

Complete!
Loaded plugins: fastestmirror
adding repo from: https://download.docker.com/linux/centos/docker-ce.repo
grabbing file https://download.docker.com/linux/centos/docker-ce.repo to /etc/yum.repos.d/docker-ce.repo
repo saved to /etc/yum.repos.d/docker-ce.repo
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
 * base: mirror.niobeweb.net
 * epel: mirror.karneval.cz
 * extras: mirror.muvhost.com
 * updates: denizli.centos-mirror.guzel.net.tr
docker-ce-stable                                                                                                                                                                     | 3.5 kB  00:00:00
(1/2): docker-ce-stable/7/x86_64/updateinfo                                                                                                                                          |   55 B  00:00:06
(2/2): docker-ce-stable/7/x86_64/primary_db                                                                                                                                          |  46 kB  00:00:06
Resolving Dependencies
--> Running transaction check
---> Package docker-ce.x86_64 3:19.03.13-3.el7 will be installed
--> Processing Dependency: container-selinux >= 2:2.74 for package: 3:docker-ce-19.03.13-3.el7.x86_64
--> Processing Dependency: containerd.io >= 1.2.2-3 for package: 3:docker-ce-19.03.13-3.el7.x86_64
--> Processing Dependency: docker-ce-cli for package: 3:docker-ce-19.03.13-3.el7.x86_64
--> Processing Dependency: libcgroup for package: 3:docker-ce-19.03.13-3.el7.x86_64
--> Running transaction check
---> Package container-selinux.noarch 2:2.119.2-1.911c772.el7_8 will be installed
--> Processing Dependency: policycoreutils-python for package: 2:container-selinux-2.119.2-1.911c772.el7_8.noarch
---> Package containerd.io.x86_64 0:1.3.7-3.1.el7 will be installed
---> Package docker-ce-cli.x86_64 1:19.03.13-3.el7 will be installed
---> Package libcgroup.x86_64 0:0.41-21.el7 will be installed
--> Running transaction check
---> Package policycoreutils-python.x86_64 0:2.5-34.el7 will be installed
--> Processing Dependency: setools-libs >= 3.3.8-4 for package: policycoreutils-python-2.5-34.el7.x86_64
--> Processing Dependency: libsemanage-python >= 2.5-14 for package: policycoreutils-python-2.5-34.el7.x86_64
--> Processing Dependency: audit-libs-python >= 2.1.3-4 for package: policycoreutils-python-2.5-34.el7.x86_64
--> Processing Dependency: python-IPy for package: policycoreutils-python-2.5-34.el7.x86_64
--> Processing Dependency: libqpol.so.1(VERS_1.4)(64bit) for package: policycoreutils-python-2.5-34.el7.x86_64
--> Processing Dependency: libqpol.so.1(VERS_1.2)(64bit) for package: policycoreutils-python-2.5-34.el7.x86_64
--> Processing Dependency: libapol.so.4(VERS_4.0)(64bit) for package: policycoreutils-python-2.5-34.el7.x86_64
--> Processing Dependency: checkpolicy for package: policycoreutils-python-2.5-34.el7.x86_64
--> Processing Dependency: libqpol.so.1()(64bit) for package: policycoreutils-python-2.5-34.el7.x86_64
--> Processing Dependency: libapol.so.4()(64bit) for package: policycoreutils-python-2.5-34.el7.x86_64
--> Running transaction check
---> Package audit-libs-python.x86_64 0:2.8.5-4.el7 will be installed
---> Package checkpolicy.x86_64 0:2.5-8.el7 will be installed
---> Package libsemanage-python.x86_64 0:2.5-14.el7 will be installed
---> Package python-IPy.noarch 0:0.75-6.el7 will be installed
---> Package setools-libs.x86_64 0:3.3.8-4.el7 will be installed
--> Finished Dependency Resolution

Dependencies Resolved

============================================================================================================================================================================================================
 Package                                               Arch                                  Version                                                  Repository                                       Size
============================================================================================================================================================================================================
Installing:
 docker-ce                                             x86_64                                3:19.03.13-3.el7                                         docker-ce-stable                                 24 M
Installing for dependencies:
 audit-libs-python                                     x86_64                                2.8.5-4.el7                                              base                                             76 k
 checkpolicy                                           x86_64                                2.5-8.el7                                                base                                            295 k
 container-selinux                                     noarch                                2:2.119.2-1.911c772.el7_8                                extras                                           40 k
 containerd.io                                         x86_64                                1.3.7-3.1.el7                                            docker-ce-stable                                 29 M
 docker-ce-cli                                         x86_64                                1:19.03.13-3.el7                                         docker-ce-stable                                 38 M
 libcgroup                                             x86_64                                0.41-21.el7                                              base                                             66 k
 libsemanage-python                                    x86_64                                2.5-14.el7                                               base                                            113 k
 policycoreutils-python                                x86_64                                2.5-34.el7                                               base                                            457 k
 python-IPy                                            noarch                                0.75-6.el7                                               base                                             32 k
 setools-libs                                          x86_64                                3.3.8-4.el7                                              base                                            620 k

Transaction Summary
============================================================================================================================================================================================================
Install  1 Package (+10 Dependent packages)

Total download size: 93 M
Installed size: 390 M
Downloading packages:
(1/11): audit-libs-python-2.8.5-4.el7.x86_64.rpm                                                                                                                                     |  76 kB  00:00:05
(2/11): container-selinux-2.119.2-1.911c772.el7_8.noarch.rpm                                                                                                                         |  40 kB  00:00:05
(3/11): checkpolicy-2.5-8.el7.x86_64.rpm                                                                                                                                             | 295 kB  00:00:06
warning: /var/cache/yum/x86_64/7/docker-ce-stable/packages/docker-ce-19.03.13-3.el7.x86_64.rpm: Header V4 RSA/SHA512 Signature, key ID 621e9f35: NOKEY                    ] 5.6 MB/s |  37 MB  00:00:09 ETA
Public key for docker-ce-19.03.13-3.el7.x86_64.rpm is not installed
(4/11): docker-ce-19.03.13-3.el7.x86_64.rpm                                                                                                                                          |  24 MB  00:00:10
(5/11): libcgroup-0.41-21.el7.x86_64.rpm                                                                                                                                             |  66 kB  00:00:00
(6/11): policycoreutils-python-2.5-34.el7.x86_64.rpm                                                                                                                                 | 457 kB  00:00:00
(7/11): python-IPy-0.75-6.el7.noarch.rpm                                                                                                                                             |  32 kB  00:00:00
(8/11): setools-libs-3.3.8-4.el7.x86_64.rpm                                                                                                                                          | 620 kB  00:00:00
(9/11): containerd.io-1.3.7-3.1.el7.x86_64.rpm                                                                                                                                       |  29 MB  00:00:12
(10/11): docker-ce-cli-19.03.13-3.el7.x86_64.rpm                                                                                                                                     |  38 MB  00:00:04
(11/11): libsemanage-python-2.5-14.el7.x86_64.rpm                                                                                                                                    | 113 kB  00:00:05
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Total                                                                                                                                                                       5.7 MB/s |  93 MB  00:00:16
Retrieving key from https://download.docker.com/linux/centos/gpg
Importing GPG key 0x621E9F35:
 Userid     : "Docker Release (CE rpm) <docker@docker.com>"
 Fingerprint: 060a 61c5 1b55 8a7f 742b 77aa c52f eb6b 621e 9f35
 From       : https://download.docker.com/linux/centos/gpg
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Installing : libcgroup-0.41-21.el7.x86_64                                                                                                                                                            1/11
  Installing : setools-libs-3.3.8-4.el7.x86_64                                                                                                                                                         2/11
  Installing : audit-libs-python-2.8.5-4.el7.x86_64                                                                                                                                                    3/11
  Installing : checkpolicy-2.5-8.el7.x86_64                                                                                                                                                            4/11
  Installing : python-IPy-0.75-6.el7.noarch                                                                                                                                                            5/11
  Installing : 1:docker-ce-cli-19.03.13-3.el7.x86_64                                                                                                                                                   6/11
  Installing : libsemanage-python-2.5-14.el7.x86_64                                                                                                                                                    7/11
  Installing : policycoreutils-python-2.5-34.el7.x86_64                                                                                                                                                8/11
  Installing : 2:container-selinux-2.119.2-1.911c772.el7_8.noarch                                                                                                                                      9/11
  Installing : containerd.io-1.3.7-3.1.el7.x86_64                                                                                                                                                     10/11
  Installing : 3:docker-ce-19.03.13-3.el7.x86_64                                                                                                                                                      11/11
  Verifying  : libsemanage-python-2.5-14.el7.x86_64                                                                                                                                                    1/11
  Verifying  : containerd.io-1.3.7-3.1.el7.x86_64                                                                                                                                                      2/11
  Verifying  : 3:docker-ce-19.03.13-3.el7.x86_64                                                                                                                                                       3/11
  Verifying  : 1:docker-ce-cli-19.03.13-3.el7.x86_64                                                                                                                                                   4/11
  Verifying  : 2:container-selinux-2.119.2-1.911c772.el7_8.noarch                                                                                                                                      5/11
  Verifying  : python-IPy-0.75-6.el7.noarch                                                                                                                                                            6/11
  Verifying  : checkpolicy-2.5-8.el7.x86_64                                                                                                                                                            7/11
  Verifying  : policycoreutils-python-2.5-34.el7.x86_64                                                                                                                                                8/11
  Verifying  : audit-libs-python-2.8.5-4.el7.x86_64                                                                                                                                                    9/11
  Verifying  : setools-libs-3.3.8-4.el7.x86_64                                                                                                                                                        10/11
  Verifying  : libcgroup-0.41-21.el7.x86_64                                                                                                                                                           11/11

Installed:
  docker-ce.x86_64 3:19.03.13-3.el7

Dependency Installed:
  audit-libs-python.x86_64 0:2.8.5-4.el7          checkpolicy.x86_64 0:2.5-8.el7             container-selinux.noarch 2:2.119.2-1.911c772.el7_8          containerd.io.x86_64 0:1.3.7-3.1.el7
  docker-ce-cli.x86_64 1:19.03.13-3.el7           libcgroup.x86_64 0:0.41-21.el7             libsemanage-python.x86_64 0:2.5-14.el7                      policycoreutils-python.x86_64 0:2.5-34.el7
  python-IPy.noarch 0:0.75-6.el7                  setools-libs.x86_64 0:3.3.8-4.el7

Complete!
Created symlink from /etc/systemd/system/multi-user.target.wants/docker.service to /usr/lib/systemd/system/docker.service.
Docker installation:                    ==> done
----------------------------------------------------------------

- Install Docker Compose.
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   651  100   651    0     0    109      0  0:00:05  0:00:05 --:--:--   146
100 11.6M  100 11.6M    0     0   836k      0  0:00:14  0:00:14 --:--:-- 3148k
Docker Compose installation:                    ==> done
----------------------------------------------------------------

- Deploy self signed SSL cert for Zabbix UI.
Generating a 2048 bit RSA private key
...............................................................................+++
.........................+++
writing new private key to '/root/secopstech-zabbix-server-4e981d22ae91/scripts/../zbx_env/etc/ssl/nginx/ssl.key'
-----
Generating DH parameters, 2048 bit long safe prime, generator 2
This is going to take a long time
.............................+.....................................................++*++*
Self signed SSL deployment for zabbix:                  ==> done
----------------------------------------------------------------

- Deploy self signed SSL cert for Grafana UI.
Generating a 2048 bit RSA private key
..........+++
...........................................+++
writing new private key to '/root/secopstech-zabbix-server-4e981d22ae91/scripts/../zbx_env/etc/ssl/grafana/ssl.key'
-----
Generating DH parameters, 2048 bit long safe prime, generator 2
This is going to take a long time
..........................................................................................................+................................................................................................................................................................+......................................................+.............................................................................................................................................................................................................................................................................+..............................................+....................................................................+...................................................................................+........................................................................................+..+....................+...................................................+.............................................................................+....+...................................+........................................................+..............................................................................................................................................................+...................................................................................+................................................................................+...............................................................................+.........................................................................................+.................................................................................................................................+............................+..........................................................................................................................+................................................................+.............................................................................+......................................................................................+............................................................................................................................................................................................................................+........................................................+.+........................+.............+............+.....................................................................................................................................................................................................................................................+...................................................................................................................................................+................................+.............................+....................................................................................................................................................+..............................................................................+...................................................................................................................+.....................+.+..............................+....................................................................................................................................................................+....................+......................+.........+.................................................+........+....................................+.......+.......................................................................................................................................................................................................+...........+............................................................................................+.....................................................................................+...........................................................................+......................................................................+.............................................+....+..............................+......................................................................+...............................................................................................................+.......................................+..........................................................+...................................................................................................................................................................................+...............................................................................................+..........+..............+.....................................................+..................................................................................................................................+...............................................................................................+........................................................................................................................................................+.............................................................................................+.......................................................................................................................................................................................................................................................................................................................................................................................................................................+...................+........................................................................................................................................................+.........................................................+..........................+.................+.......................................................................................................................................................................................................................................................................................+...........................................................................+....................................+.........+................................................................................+................................................................................................................+.............................................+...................+............................................................................................................................+.............+.......................................................................................................................+.....................+..........................................................................................................................................................................................................................................................................................................................................+...............................................................................................................................................................+...................................................................................................................................................................................................................+...........................................................................................................................................................................................................................................+........................................+...............................................+..............................................................................+...................................................+..............................................................................................+..............................................................................................................................................................+.................................................+............................................+............................................................................................+.....................................................................................+..+.......................................................................+........................................+.......................................................................................................................................................+...+......................+.....+.................................................+........+.............................+..............................................+..................................................................+......................................................................................+...................+......................................................................................................................................................+............+..........................................................................................................................+............................................................................................................................................................+........................................................................................................................................+...........................................+...............................................................................................................................................................................................................................................+...........................................................................................................................................................................................+.............................................................................................................................................................................................+............................................................................................................+...................+..........................................................................+.....+....+...........................+....................+..................................................................................................................................................................................................+..................................+..........................................................................................+.....................................................................................................................................................................................................+..........................................................................+....................................................................................................................................................................+...+...............................................................................................................................................................+...............................................................................................+..................................................+..........................................................................................................................................................................................................................................................+...........................................+...............................+................................+.................................................................+.......................................................................................................................................................................................+...........................................................................................................+..............................++*++*
Self signed SSL deployment for grafana:                 ==> done
----------------------------------------------------------------

- Dockerized zabbix server deployment.
----------------------------------------------------------------
Creating network "secopstech-zabbix-server-4e981d22ae91_zbx_net_backend" with driver "bridge"
Creating network "secopstech-zabbix-server-4e981d22ae91_zbx_net_frontend" with driver "bridge"
Creating volume "secopstech-zabbix-server-4e981d22ae91_mysql-data" with default driver
Creating volume "secopstech-zabbix-server-4e981d22ae91_grafana-data" with default driver
Creating volume "secopstech-zabbix-server-4e981d22ae91_snmptraps" with default driver
Pulling zabbix-java-gateway (zabbix/zabbix-java-gateway:alpine-5.0-latest)...
alpine-5.0-latest: Pulling from zabbix/zabbix-java-gateway
df20fa9351a1: Pull complete
70165cb0581b: Pull complete
5fefca5e2740: Pull complete
44b14973ff9e: Pull complete
080b972f930a: Pull complete
7efed4e94f7f: Pull complete
2621de038edc: Pull complete
Digest: sha256:8e242a3348db32d8da2d9b085b70ccd8a1797b2e062979ebf125151f78a42a2c
Status: Downloaded newer image for zabbix/zabbix-java-gateway:alpine-5.0-latest
Pulling zabbix-snmptraps (zabbix/zabbix-snmptraps:alpine-5.0-latest)...
alpine-5.0-latest: Pulling from zabbix/zabbix-snmptraps
df20fa9351a1: Already exists
16ff1510b667: Pull complete
55e15fea3c92: Pull complete
4e12546d355e: Pull complete
89e647f2a747: Pull complete
64c5b64783cd: Pull complete
Digest: sha256:6cb1ed4b99d40f29774e06f536d96e3a207871a0992655a8ee86d0c2adde56fc
Status: Downloaded newer image for zabbix/zabbix-snmptraps:alpine-5.0-latest
Pulling mysql-server (mysql:8.0)...
8.0: Pulling from library/mysql
bb79b6b2107f: Pull complete
49e22f6fb9f7: Pull complete
842b1255668c: Pull complete
9f48d1f43000: Pull complete
c693f0615bce: Pull complete
8a621b9dbed2: Pull complete
0807d32aef13: Pull complete
9eb4355ba450: Pull complete
6879faad3b6c: Pull complete
164ef92f3887: Pull complete
6e4a6e666228: Pull complete
d45dea7731ad: Pull complete
Digest: sha256:86b7c83e24c824163927db1016d5ab153a9a04358951be8b236171286e3289a4
Status: Downloaded newer image for mysql:8.0
Pulling zabbix-server (zabbix/zabbix-server-mysql:alpine-5.0-latest)...
alpine-5.0-latest: Pulling from zabbix/zabbix-server-mysql
df20fa9351a1: Already exists
ef616cc9bee5: Pull complete
074edc16fb87: Pull complete
d52223a56c6c: Pull complete
5e2dd4bc2755: Pull complete
Digest: sha256:b4af038542c806b4164c1e5be66edb7461fc0a29274b1a2e617329424fd530e4
Status: Downloaded newer image for zabbix/zabbix-server-mysql:alpine-5.0-latest
Pulling zabbix-agent (zabbix/zabbix-agent:alpine-5.0-latest)...
alpine-5.0-latest: Pulling from zabbix/zabbix-agent
df20fa9351a1: Already exists
71c4b0605a4e: Pull complete
cf3d3610e05c: Pull complete
2537f4545b8e: Pull complete
bf0956b94b60: Pull complete
Digest: sha256:f6807de540067e89a17b25bd78b3fc0555b9ffbff056154de2a7888a3601e0a9
Status: Downloaded newer image for zabbix/zabbix-agent:alpine-5.0-latest
Pulling zabbix-web-nginx-mysql (zabbix/zabbix-web-nginx-mysql:alpine-5.0-latest)...
alpine-5.0-latest: Pulling from zabbix/zabbix-web-nginx-mysql
df20fa9351a1: Already exists
d5e67c3ba267: Pull complete
51eafb8ca26a: Pull complete
b805e9ed26ca: Pull complete
bc5f2fa1d10d: Pull complete
3a206250bf31: Pull complete
Digest: sha256:836177157a51fe86bbb60a062338f5e3243f39585cfcc82ac8d9ffa15c249656
Status: Downloaded newer image for zabbix/zabbix-web-nginx-mysql:alpine-5.0-latest
Pulling grafana-server (grafana/grafana:7.2.1)...
7.2.1: Pulling from grafana/grafana
df20fa9351a1: Already exists
5f101b91128e: Pull complete
06b22e47f660: Pull complete
e8278dc77f35: Pull complete
4ac3c61790c9: Pull complete
e5505e948ec3: Pull complete
Digest: sha256:733842cca5bd9bcab1eb795da264863a8245402ff3ac8ff17e274334bb32c692
Status: Downloaded newer image for grafana/grafana:7.2.1
Creating secopstech-zabbix-server-4e981d22ae91_zabbix-snmptraps_1    ... done
Creating secopstech-zabbix-server-4e981d22ae91_zabbix-java-gateway_1 ... done
Creating secopstech-zabbix-server-4e981d22ae91_grafana-server_1      ... done
Creating secopstech-zabbix-server-4e981d22ae91_mysql-server_1        ... done
Creating secopstech-zabbix-server-4e981d22ae91_zabbix-server_1       ... done
Creating secopstech-zabbix-server-4e981d22ae91_zabbix-web-nginx-mysql_1 ... done
Creating secopstech-zabbix-server-4e981d22ae91_zabbix-agent_1           ... done
- Waiting for 5 seconds to zabbix server getting be ready... ( 23 retries left )
- Waiting for 5 seconds to zabbix server getting be ready... ( 22 retries left )
- Waiting for 5 seconds to zabbix server getting be ready... ( 21 retries left )
- Waiting for 5 seconds to zabbix server getting be ready... ( 20 retries left )
- Waiting for 5 seconds to zabbix server getting be ready... ( 19 retries left )
- Waiting for 5 seconds to zabbix server getting be ready... ( 18 retries left )

Zabbix deployment:                              ==> done
----------------------------------------------------------------

- Create hosts groups.
BSD servers:                                    ==> done
Windows servers:                                        ==> done
Firewalls:                                      ==> done
Routers:                                        ==> done
Switches:                                       ==> done
Netscalers:                                     ==> done
Nginx servers:                                  ==> done
Apache servers:                                 ==> done
Litespeed servers:                                      ==> done
Haproxy servers:                                        ==> done
Tomcat servers:                                 ==> done
NodeJS servers:                                 ==> done
JVM servers:                                    ==> done
IIS servers:                                    ==> done
MySQL servers:                                  ==> done
PostgreSQL servers:                                     ==> done
MongoDB servers:                                        ==> done
Oracle servers:                                 ==> done
MSSQL servers:                                  ==> done
RabbitMQ servers:                                       ==> done
Couchbase servers:                                      ==> done
Redis servers:                                  ==> done
Kafka servers:                                  ==> done
Docker servers:                                 ==> done
Kubernetes servers:                                     ==> done
Openshift servers:                                      ==> done
Mesos servers:                                  ==> done
----------------------------------------------------------------

- Create auto registration actions.
Linux auto registration action:                         ==> done
Win auto registration action:                           ==> done
----------------------------------------------------------------

- Tune Linux OS Template.
Set filesystem discovery LLD interval to 30m:           ==> done
Create an item protoype to get free disk space as percentage for all partitions:                ==> done
Set netif discovery LLD interval to 5m:                 ==> done
Set total memory check interval to 5m:                  ==> done
Set total swap check interval to 30m:                   ==> done
Set Number of CPUs interval to 5m:                      ==> done
----------------------------------------------------------------

- Tune Windows OS Template.
Create an item protoype to get free disk space as percentage for all partitions:                ==> done
Set filesystem discovery LLD interval to 30m:           ==> done
Set netif discovery LLD interval to 30m:                        ==> done
Create fee mem item as percentage:                      ==> done
Disable annoying Windows service items LLD rule:        ==> done

- Create a read-only user for Zabbix API.
Create API user group:                          ==> done
Create API user:                                ==> done
----------------------------------------------------------------

- Monitor Zabbix Server itself.
Update Zabbix host interface:                   ==> done
Enable Zabbix agent:                            ==> done
----------------------------------------------------------------

- Grafana configurations.
Enable grafana zabbix plugin:                   ==> done
Create a grafana API key:                       ==> done
Create Grafana datasource for zabbix:           ==> done
Default zabbix dashboard not found.             ==> skipped
Import Linux servers dashboard:                 ==> done
Import Windows servers dashboard:               ==> done
Import Zabbix system status dashboard:          ==> done
----------------------------------------------------------------

- NOTIFICATION CONFIGURATIONS.

 Do you want to enable email notification ? (Yes or No):  yes

- Zabbix SMTP settings.
 SMTP server settings will be configured to send notifications emails.
 Please provide your SMTP server IP( or host), Port, sender email
 security prefrence and auth credentials

 Enter SMTP Server Address:  1.1.1.1
 Enter  SMTP Server Port: 25
 Enter SMTP Hello:  ehlooo
 Enter Sender Email:  zabbix@secops.tech
 Enable connection security ? (Yes or No):  yes
 Enter connection security type? (STARTTLS or SSL/TLS):  TLS
 Enable authentication ? (Yes or No):  yes
 Enter username for SMTP Auth:  a
 Enter password for SMTP Auth:  a

- Admin email notification settings.
 This will set the admin email address to get zabbix alerts,
 and enable the trigger action for the notifications...

 Enter an email address for admin user:  zabbix@secops.tech
SMTP notification configuration:                ==> done
Set admin's email address:                      ==> done
Enable notifications for admin group:           ==> done
----------------------------------------------------------------

 Do you want to enable slack notifications ? (Yes or No):  yes

- Slack settings.
This section, enables slack notification.
An slack app must be created within your Slack.com workspace
s explained at https://git.zabbix.com/projects/ZBX/repos/zabbix/browse/templates/media/slack
Please create the slack app now and provide its Bot User OAuth Access Token, and slack channel name.

 Enter your Bot User OAuth Access Token:  xoxb-19021783321-98246913619-V9JSLjlkejlkSJL19
 Enter your slack channel:  zabbix
Creating a global macro for Zabbix URL:         ==> done
Adding bot token to slack medita type:          ==> done
Adding slack and smtp media types to admin user:                ==> done

Zabbix installation successfuly finished.
-----------------------------------------------------------------

Zabbix UI is accessible at https://ip:8443
Username: Admin
Pasword: zabbix (Don't forget to change it!)

Grafana UI is accessible at https://ip:3000
Username: admin
Pasword: zabbix (Don't forget to change it too!)
-----------------------------------------------------------------

For any contribution or issue reporting please visit https://bitbucket.org/secopstech/zabbix-server/issues.
```