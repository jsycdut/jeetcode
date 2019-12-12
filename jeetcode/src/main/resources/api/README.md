# leetcode-api

经过我的分析，发现leetcode他们是提供了api的，虽然不对外公开，但是可以通过在网页端进行分析获取几乎所有的api，包括题目列表、题目详细信息（题目正文，语言模板）、题目搜索、代码测试、提交、历史记录等。其中有一些可以直接通过api访问，但是有一些必须加上用户信息（比如提交编写的代码的时候），相关的api我都放到了[leetcode-api-test.sh](./leetcode-api-test.sh)中，主要是基于curl进行请求访问。

## 学习资料

* [curl-basic-usage](https://gist.github.com/subfuzion/08c5d85437d5d4f00e58)
