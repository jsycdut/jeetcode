#!/bin/bash

#=======================================
#  leetcode 英文站点api分析测试
#=======================================

# 请求头referer url
referer="https://leetcode.com/problemset/algorithms/"

# 获取所有的题目，GET
# 所有的信息里面包含一个stat子节点，里面包含着question_title_slug
# 这个是获取具体题目内容的重要搜索字符串，很多请求参数里面就有这个slug
# 另外注意front_question_id，这个是显示到网页前端的题目id
# 另外有一个question_id，这个是leetcode后台显示题目的id
# 在下面的搜索时，返回的就是后台题目id，然后映射到前端id
# 最后通过对应的slug进行进一步的搜索
all_question_api="https://leetcode.com/api/problems/algorithms/"
curl $all_question_api > all-problems.json

# 搜索问题API, GET
# 只需在下面的URL后跟上你的题号或者搜索内容即可
# 会返回一个数字数组，这里的数字是对应的题目后台id
filter_api="https://leetcode.com/problems/api/filter-questions/"
curl $filter_api/two-sum > filter-problems.json

# 请求特定题目信息的前缀URL, POST
# 对应的请求是使用json格式组织信息的post请求
target="https://leetcode.com/graphql"
curl -X POST -H "Content-Type: application/json" -d @two-sum-query.json $target > two-sum-detail.json
