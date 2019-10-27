#!/bin/bash
#list all iam users, create new txt file, add the user in the txt file
aws iam list-users --output text | awk '{print $3,$6}' > iam_user_info.txt

