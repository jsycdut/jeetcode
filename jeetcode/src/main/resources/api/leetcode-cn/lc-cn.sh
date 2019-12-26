#!/bin/bash

if [[ ! -f corlorful-output.sh ]]; then
  curl -o corlorful-output.sh https://raw.githubusercontent.com/jsycdut/scripts/master/shell/corlorful-output.sh
fi

# get colorful output functions
source corlorful-output.sh

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
  error_prompt error! empty user name.
  exit -1
fi

if [[ -z $password ]]; then
  error_prompt error! empty password.
  exit -1
fi

info_prompt "Login Information: user: $user_name password: $password "

# get cookie

curl -c cookie $query_url > /dev/null

if [[ ! -f cookie ]]; then
  error_prompt "$query_url doesn not set cookie."
  exit -1
else
  info_prompt " Cookie"
  cat cookie
fi

token=`grep csrftoken cookie | awk '{print $7}'`

if [[ -z $token ]]; then
  error_prompt "No csrftoken field found in cookie file."
  exit -1
else
  info_prompt "csrftoken $token "
fi

# login by user_name and password
curl -i -L -e $login_url $use_cookie $post_form -d "csrfmiddlewaretoken=$token&login=$user_name&password=$password&next=/problems/all" $login_url > /dev/null

session=`grep LEETCODE_SESSION cookie`

if [[ -n $session ]]; then
  info_prompt Login as $user_name successfully.
else
  error_prompt Login failed.
fi

# user stat
# curl -i -L -e $login $use_cookie $post_json @get-user-stat.json $query > user-stat.json


# submissions
# curl -L -e $login $cookie $post_json @get-submissions.json $query > get_submissions.json

# get specific submission-code
