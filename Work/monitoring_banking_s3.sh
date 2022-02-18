#!/bin/bash

######################################
#          ZOOP - BANKING            #
#    ---------------------------     #
#   SCRIPT FOR MONITORING CIP FILE   #
######################################
#                                    #
#  Created by: Anderson Menezes      #
#                                    #
#  Last update by: Anderson Menezes  #
#                                    #
#  Last update made in: 2021/03/05   #
#                                    #
######################################


if [ $# -eq 1 ]; then
    SIZE_DEC=`aws s3 ls ${1} --summarize | grep "Total Size:" | awk -F " " '{print $3}' | bc`
    SIZE=`echo "${SIZE_DEC%.*}"`
else
    echo "Usage: ${0} BucketName"
    exit 1
fi