#!/usr/bin/env bash
#************************************************#
# 文件名：SYSCHK_LINUX_ABNORJOB.sh            #
# 作  者：ycl                            #
# 日  期：2015年 09月24日                        #
# 功  能：检查数据库失效的job       #
# 复核人：                                       #
#************************************************#
#脚本描述
#keys:jobid|job标示符|string,user|执行用户|string,broken|中断信号|string|例如:N、Y,failures|错误次数|int
#describe:检查数据库 失效的job
#threshold:
#stype:list
#version:g.0.1

#参数定义
LANG=en_US.utf8
basepath=$(dirname $0)
bname=$(basename $0)
tmpfile="/tmp/${bname}.$$"

#调用sqlplus 库脚本
sqlplus -S "/as sysdba" 1>&2 2>/dev/null <<EOF
 @${basepath}/../sqllib/invalidjob.sql $tmpfile
EOF

#output
[ -f $tmpfile ] && (cat $tmpfile ; rm $tmpfile)
