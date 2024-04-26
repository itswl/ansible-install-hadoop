#!/bin/bash
set -e

script_abs=$(readlink -f "$0") # 获取当前脚本绝对路径
readonly CURR_PATH=$(dirname $script_abs)
PLAYBOOK_TASK_LOG="/tmp/bap_playbook_task.log"

echo "ansible-playbook -i $CURR_PATH/../conf/hosts $CURR_PATH/../data/plays/hadoop.yml 2>&1 | tee -a $PLAYBOOK_TASK_LOG"

ansible-playbook -i $CURR_PATH/../conf/hosts $CURR_PATH/../data/plays/hadoop.yml 2>&1 | tee -a $PLAYBOOK_TASK_LOG
