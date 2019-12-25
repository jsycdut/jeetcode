#!/bin/bash

# echo "**********   **********"

# url shorthand
login_url="https://leetcode-cn.com/accounts/login/"
two_sum_url="https://leetcode-cn.com/problems/two-sum/"
query_url="https://leetcode-cn.com/graphql/"
home_url="https://leetcode-cn.com"

# user shorthand
user_name=""
password=""
token=""

# curl parameters shorthand
use_cookie="-b cookie -c cookie"
post_json="-X POST -H Content-Type: application/json -d"
post_form="-X POST"

# read user name and password
while IFS= read -r line; do
  if [[ $line =~ ^user ]]; then
    user_name=${line:10}
  else
    password=${line:9}
  fi
done < auth

# check
if [[ -z $user_name ]]; then
  echo error! empty user name.
  exit -1
fi

if [[ -z $password ]]; then
  echo error! empty password.
  exit -1
fi

echo "********** Login Information:  $user_name $password "

# get cookie

curl -s -c cookie $query_url > /dev/null

if [[ ! -f cookie ]]; then
  echo "********** error! $query_url doesn not set cookie. **********"
  exit -1
else
  echo "********** Cookie"
  cat cookie
fi

# login
#curl -i -L -e $login $use_cookie $post_form -d "csrfmiddlewaretoken="$token"&login="user_name"&password="$password"&next=/problems/all" $login_url

# user stat
# curl -L -e $login $use_cookie $post_json @get-user-stat.json $query > user-stat.json


# submissions
# curl -L -e $login $cookie $post_json @get-submissions.json $query > get_submissions.json

# get specific submission-code
