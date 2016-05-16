#!/bin/bash -x

MAGENTO_ROOT="/magento"

PHP="/usr/local/bin/php -d memory_limit=2G"
PHPUNIT_CONFIGURATION="$MAGENTO_ROOT/dev/tests/integration/phpunit.xml.dist"
MYSQL_CONFIGURATION="$MAGENTO_ROOT/dev/tests/integration/etc/install-config-mysql.php"
PHPUNIT="$PHP $MAGENTO_ROOT/vendor/bin/phpunit -c $PHPUNIT_CONFIGURATION --log-junit /mnt/test-results/junit-integration.xml $*"

echo "<?php
/**
 * Copyright © 2015 Magento. All rights reserved.
 * See COPYING.txt for license details.
 */

return [
    'db-host' => 'db',
    'db-user' => 'root',
    'db-password' => 'magento2',
    'db-name' => 'magento_integration_tests',
    'db-prefix' => '',
    'backend-frontname' => 'backend',
    'admin-user' => \Magento\TestFramework\Bootstrap::ADMIN_NAME,
    'admin-password' => \Magento\TestFramework\Bootstrap::ADMIN_PASSWORD,
    'admin-email' => \Magento\TestFramework\Bootstrap::ADMIN_EMAIL,
    'admin-firstname' => \Magento\TestFramework\Bootstrap::ADMIN_FIRSTNAME,
    'admin-lastname' => \Magento\TestFramework\Bootstrap::ADMIN_LASTNAME,
];
" > ${MYSQL_CONFIGURATION}

${PHPUNIT} "/src/extensions/meanbee-example-magento2-module/src/Test/Integration"

exit 0
