#!/bin/bash

login="https://leetcode-cn.com/accounts/login/"
two_sum="https://leetcode-cn.com/problems/two-sum/"
query="https://leetcode-cn.com/graphql/"

cookie="-b login-cookie -c login-cookie"
post_json="-X POST -H Content-Type: application/json -d"

# login
#curl -i -L -e $login -b first-visit-cookie -c login-cookie -X POST -d "csrfmiddlewaretoke=Posav0eRCJ2jXZ6AnawWyWPS0adS3VCw3HFaBuO8FYTQUmSkwGzjJh7OrlXcayHQ&login=17780696327&password=jsycdut08&next=/problems/all" $login

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

