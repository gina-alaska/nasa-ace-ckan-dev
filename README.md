# nace-dev

CKAN Documentation: http://docs.ckan.org/en/latest/

## Dependencies

* vagrant
* virtualbox
* git

## Getting started

Install vagrant plugins

```
vagrant plugin install vagrant-omnibus vagrant-berkshelf vagrant-share
```

Clone this repository and start vm

```
git clone --recursive https://github.alaska.edu/gina/nasa-ace-ckan-dev.git
cd nasa-ace-ckan-dev
vagrant up
```

Once the vagrant instance has finished starting open http://192.168.0.17:8080/ in your browser to access the ckan interface

### How to create a system admin account

http://docs.ckan.org/en/latest/maintaining/getting-started.html#create-admin-user
