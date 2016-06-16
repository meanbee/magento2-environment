#!/bin/bash

PHP="/usr/local/bin/php"
COMPOSER="$PHP /usr/local/bin/composer"

MAGENTO_TOOL="magento-command"

cd $MAGENTO_ROOT

# This is required because Magento doesn't support the path type in composer
# this is a hack.
ln -s /src/ src

$COMPOSER config repositories.meanbee_example-magento2-module path /src/extensions/meanbee-example-magento2-module

$COMPOSER require "meanbee/example-magento2-module" "*"

# Required due to us using the "path" type for the repository
$COMPOSER require "composer/composer" "1.0.0-alpha11 as 1.0.0-alpha10"

$MAGENTO_TOOL module:enable Meanbee_ExampleMagento2Module
$MAGENTO_TOOL setup:upgrade
$MAGENTO_TOOL setup:static-content:deploy
$MAGENTO_TOOL cache:flush
$MAGENTO_TOOL deploy:mode:set developer
