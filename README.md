
vagrant-irods\_ebrc\_prod_model
=====

About
=====

This Vagrant project manages a Virtualbox virtual machine that roughly
models the iRODS implementation at EuPathDB BRC. It is intended as a
sandbox environment for use by application developers to code against
and to experiment with rules and microservices.

It has no value to anyone outside the EBRC project and the vagrant box
is not publicly accessible.

Prerequisites
=====

Vagrant
---------------

Vagrant manages the lifecycle of the virtual machine, guided by the instructions in the `Vagrantfile` included with this project.

[https://www.vagrantup.com/downloads.html](https://www.vagrantup.com/downloads.html)

You should refer to Vagrant documentation and related online forums for information not covered in this document.

VirtualBox
------------------

Vagrant needs VirtualBox to host the virtual machine defined in this project's `Vagrantfile`. Other virtualization software (e.g. VMWare) are not compatible with this Vagrant project as it is currently configured.

[https://www.virtualbox.org/wiki/Downloads](https://www.virtualbox.org/wiki/Downloads)

You should refer to VirtualBox documentation and related online forums for information not covered in this document.

Vagrant Landrush Plugin (Optional)
--------------------------------------

The [Landrush](https://github.com/phinze/landrush) plugin for Vagrant provides a local DNS so you can register guest hostnames and refer to them in the host browser. It is not strictly required but it makes life easier than editing `/etc/hosts` files. This plugin has maximum benefit for OS X hosts, some benefit for Linux hosts and no benefit for Windows. Windows hosts will need to edit `hosts` files.

    vagrant plugin install landrush

_If you have trouble getting the host to resolve guest hostnames through landrush try clearing the host DNS cache by running_ `sudo killall -HUP mDNSResponder`.

If you want to host multiple product sites - say, sa.vm.toxodb.org and sa.vm.giardiadb.org - you may want our Landrush fork that supports multiple TLD management. Until and unless our [Pull Request](https://github.com/phinze/landrush/pull/125) is accepted by the upstream maintainer you will have to manually build and install the plugin from source.

    git clone https://github.com/mheiges/landrush.git
    cd landrush
    rake build
    vagrant plugin install pkg/landrush-0.18.0.gem

You should refer to Landrush and Vagrant documentation and related online forums for information not covered in this document.

Usage
=======

Clone This Vagrant Project
--------------------------

    git clone https://github.com/EuPathDB/vagrant-irods_ebrc_prod_model.git

Start the Virtual Machine
-------------------------

    cd vagrant-irods_ebrc_prod_model

    vagrant up

ssh to the Virtual Machine
-----------------

To connect to the VM as the `vagrant` user, run

    vagrant ssh

iRODS Basics
=======

host
--------

The iCAT enable server is **`ies.irods.vm`**, the irods server port is `1247`.


zone
--------

The zone is **ebrc**.

accounts
--------

Listed as `username/password`

  - `icatadmin/passWORD` : full administrator of the irods zone, i.e.
  can run all the `iadmin` commands.
  - `wrkspuser/passWORD` : iRODS account for workspaces development.
  This has read/write rights to `/ebrc/workspaces`.
  - `rods` : (no password) The operating system account that runs the irods
  processes. This system account is preconfigured with `icatadmin`
  credentials and that should not be changed. You can `sudo su - irods`
  to access this system account and then issue iCommands as the irods
  administrator.
  - `irods/passWORD` : The admin account for the `ICAT` Postgres
  database. You typically should not need to tinker in the database, but
  if you must, you can get in with

          PGPASSWORD=passWORD psql -U irods -h localhost ICAT


resources
---------

The default resource is **`ebrcResc`**

Example `iinit`
-------------

Putting together the above, here's an example `iinit` to log in as the `wrkspuser`.

    [vagrant@ies ~]$ iinit
    One or more fields in your iRODS environment file (irods_environment.json) are
    missing; please enter them.
    Enter the host name (DNS) of the server to connect to: ies.irods.vm
    Enter the port number: 1247
    Enter your irods user name: wrkspuser
    Enter your irods zone: ebrc
    Those values will be added to your environment file (for use by
    other iCommands) if the login succeeds.

    Enter your current iRODS password: passWORD

