#!/bin/bash -x

MAGENTO_ROOT="/magento"

PHP="/usr/local/bin/php -d memory_limit=2G"
PHPUNIT_CONFIGURATION="$MAGENTO_ROOT/dev/tests/unit/phpunit.xml.dist"
PHPUNIT="$PHP $MAGENTO_ROOT/vendor/bin/phpunit -c $PHPUNIT_CONFIGURATION --log-junit /mnt/test-results/junit.xml $*"

$PHPUNIT "/src/src/extensions/meanbee-example-magento2-module/src/Test/Unit/"

exit 0
