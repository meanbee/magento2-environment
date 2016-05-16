# Meanbee Environment Example

This repository is the development environment that Meanbee are using for their Magento 2 builds.

This repository will build a Magento 2 instance and inject the configured extensions into it.

We are currently running:

* PHP 7
* NGINX
* MySql

## Development Environment Setup

    cp composer.env.sample composer.env
    cp current.env.sample current.env

    git submodule init
    git submodule update --remote

    docker-compose run cli /usr/local/bin/magento-installer
    docker-compose run cli /tools/setup.sh
    docker-compose up -d

You can now visit [http://meanbee-environment.docker/](http://meanbee-environment.docker/)

### Configuring xDebug

You'll need to setup path mapping in *Languages & Frameworks -> PHP -> Servers*.  Assuming your checkout on your local
machine is `$basedir`, configure the following:

* `$basedir` -> `/src`
* `$basedir/src` -> `/src/src`
* `$basedir/magento` -> `/magento`
* `$basedir/magento/src` -> `/src`

##Running Tests

To run unit tests:

    docker-compose run --rm cli /tools/run_unit_tests.sh

To run integration tests:

    docker-compose run --rm cli /tools/run_integration_tests.sh

## Adding new extensions

When adding new submodules we should make sure that we are tracking against a remote branch instead of a specific commit.  To do that we need to run the following:

    git submodule add -b develop git@github.com:meanbee/example-magento2-module.git extensions/meanbee-example-magento2-module2

With the submodule added we now need to ensure that the extension is installed and configured when `bin/setup.sh` is executed.  To do this, edit `bin/setup.sh` with:

* Add local path reference to repository, e.g. `$COMPOSER config repositories.meanbee_example-magento2-module2 path /src/extensions/meanbee-example-magento2-module2`
* Require your package in Magento's `composer.json`, e.g. `$COMPOSER require "meanbee/example-magento2-module2" "*"`
* Enable your extension within Magento (if applicable), e.g. `$MAGENTO_TOOL module:enable Meanbee_ExampleMagento2Module2`
