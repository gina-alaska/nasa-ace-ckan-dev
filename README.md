# nace-dev

CKAN Documentation: http://docs.ckan.org/en/latest/

This will install build a vm with ckan installed a couple of custom plugins enabled.

The ckan theme is being customized using the `ckanext-nasa_ace` plugin.

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
touch .mapbox_token # this needs to be updated with the token but for now creating the token will be enough
vagrant up
```

Once the vagrant instance has finished starting open http://192.168.0.17:8080/ in your browser to access the ckan interface

## Custom Plugins

* `ckanext-group_private_datasets` - https://github.com/gina-alaska/ckanext-group_private_datasets.git
* `ckanext-nasa_ace` - https://github.com/gina-alaska/ckanext-nasa_ace.git

### How to create a system admin account

http://docs.ckan.org/en/latest/maintaining/getting-started.html#create-admin-user
