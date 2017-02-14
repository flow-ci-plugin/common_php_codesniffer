# ************************************************************
#
# This step will use Php anlayzer Codesniffer to check files
#
#   Variables used:
#
#   Outputs:
#     $FLOW_PHP_CODE_SNIFFER_WARNING_COUNT
#     $FLOW_PHP_CODE_SNIFFER_ERROR_COUNT
#     $FLOW_PHP_CODE_SNIFFER_FILE_COUNT
#     $FLOW_PHP_CODE_SNIFFER_LOG_PATH
#
# ************************************************************

set +e
cd $FLOW_CURRENT_PROJECT_PATH
phpbrew use $FLOW_VERSION
php --version
composer --version

FLOW_PHP_CODE_SNIFFER_LOG_PATH=${FLOW_WORKSPACE}/output/php_codesniffer.json

composer global require "squizlabs/php_codesniffer=*" --prefer-source --no-interaction

~/.composer/vendor/bin/phpcs . -d memory_limit=500M --report=summary --report-json=${FLOW_WORKSPACE}/output/php_codesniffer.json

FLOW_PHP_CODE_SNIFFER_WARNING_COUNT=$(jq ".totals.warnings" $FLOW_PHP_CODE_SNIFFER_LOG_PATH)
FLOW_PHP_CODE_SNIFFER_ERROR_COUNT=$(jq ".totals.errors" $FLOW_PHP_CODE_SNIFFER_LOG_PATH)
FLOW_PHP_CODE_SNIFFER_FILE_COUNT=$(jq ".files | length" $FLOW_PHP_CODE_SNIFFER_LOG_PATH)
