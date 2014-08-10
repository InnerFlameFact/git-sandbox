#!/bin/bash

# This file is part of the Studio Fact package.
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.

. "/etc/git-sandbox.conf"

if [ $EUID -ne 0 ]; then
  echo "This script should be run as root." > /dev/stderr
  exit 1
fi

PROJECT_NAME="$1"
PROJECT_PATH="/home/$PROJECT_USER"
PROJECT_PATH_FULL=$(echo "$PROJECT_PATH/$PROJECT_NAME")

URL_BITRIXSETUP="http://www.1c-bitrix.ru/download/scripts/bitrixsetup.php"
URL_BITRIXRESTOR="http://www.1c-bitrix.ru/download/scripts/restore.php"

if [ "$PROJECT_NAME" == '' ]; then
  read -p "Enter name project and press [ENTER]: " PROJECT_NAME
fi

if [ -d "$PROJECT_PATH_FULL" ]; then
  echo "Project '$PROJECT_NAME' already exists."
  exit 1
fi

mkdir -p ${PROJECT_PATH_FULL}

wget -qO /dev/null ${URL_BITRIXSETUP} -P ${PROJECT_PATH_FULL}
wget -qO /dev/null ${URL_BITRIXRESTOR} -P ${PROJECT_PATH_FULL}

chown -R "$PROJECT_USER:$PROJECT_GROUP" ${PROJECT_PATH_FULL}
chmod -R g+rwx ${PROJECT_PATH_FULL}