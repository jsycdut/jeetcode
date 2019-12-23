#!/bin/bash

login="https://leetcode-cn.com/accounts/login/"
two_sum="https://leetcode-cn.com/problems/two-sum/"
query="https://leetcode-cn.com/graphql/"
main="https://leetcode-cn.com"

user_name=$1
password=$2
token=$3

cookie="-b login-cookie -c login-cookie"
post_json="-X POST -H Content-Type: application/json -d"

# get cookie
curl -s -L -e $main $ -c first-visit-cookie https://leetcoe-cn.com/graphql

# login
#curl -i -L -e $login -b first-visit-cookie -c login-cookie -X POST -d "csrfmiddlewaretoken="$token"&login="user_name"&password="$password"&next=/problems/all" $login

# user stat
# curl -L -e $login $cookie $post_json @get-user-stat.json $query > user-stat.json


# submissions
# curl -L -e $login $cookie $post_json @get-submissions.json $query > submissions.json

# get specific submission-code
curl $cookie https://leetcode-cn.com/submissions/detail/15276091/ > f.html

cat f.html | grep submissionCode

# the output is not pure
code=`cat f.html | grep submissionCode`
echo $code

# submit code

