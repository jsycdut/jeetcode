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
post_json="-X POST -H Content-Type:application/json -d"
post_form="-X POST"

# read user name and password
if [[ -f auth ]]; then
  while IFS= read -r line; do
    if [[ $line =~ ^user ]]; then
      user_name=${line:10}
    else
      password=${line:9}
    fi
  done < auth
else
  read -p "your leetcode-cn account: " user_name
  read -s -p "your password: " password
  printf "\n"
  cat << EOF >> auth
user_name=$user_name
password=$password
EOF
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

  # user stat detail
  curl -s -L -e $login_url $use_cookie $post_json @../../json/fetch_global_data.json $query_url > tmp.json
  if `command -v python > /dev/null 2>&1`; then
    info_prompt "python found, now using python -m json.tool to format user_stat.json"
    cat tmp.json | python -m json.tool > user_stat.json
    username=`grep -i username user_stat.json | sed 's/[ ,"]//g'`
    realName=`grep -i realname user_stat.json | sed 's/[ ,"]//g'`
    info_prompt  'leetcode-cn.com login detail =>' $username $realName
    rm tmp.json
  else
    mv tmp.json user_stat.json
    error_prompt "no python found in environment, user_stat.json stay un-formatted"
  fi
else
  error_prompt Login failed.
  exit -1
fi

# get two-sum problem detail
curl -s -L -e $two_sum_url $post_json @../../json/fetch_problem.json $query_url | python -m json.tool > two_sum.json
content=`grep -i content two_sum.json | grep -i -v translatedcontent | sed 's/<[^>]*>//g;s/content/two-sum/'`

if [[ -n $content ]]; then
  info_prompt $content
fi
