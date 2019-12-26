# leetcode-api

经过我的分析，发现leetcode他们是提供了api的，虽然不对外公开，但是可以通过在网页端进行分析获取几乎所有的api，包括题目列表、题目详细信息（题目正文，语言模板）、题目搜索、代码测试、提交、历史记录等。其中有一些可以直接通过api访问，但是有一些必须加上用户信息（比如提交编写的代码的时候）。

目前（2019-12-26），leetcode总共有[leetcode](https://leetcode.com)和[leetcode-cn](https://leetcode-cn.com)两个站点，cn站点主要针对中文用户，两个站的登录原理大同小异，都是cookie + csrfmiddlewaretoken + login + password，不过[leetcode](https://leetcode.com)还启用了Google reCAPTCHA验证，我目前没理清它的原理，不过[leetcode-cn](https://leetcode-cn.com)没有Google reCAPTCHA，验证登录就简单一点。一般这种登录验证都是需要带cookie + referer + csrftoken验证，[leetcode-cn](https://leetcode-cn.com)就是这个路数，使用curl刚好可以满足模拟登录，再加上存放的cookie，可以进行一些模拟数据的获取。

* [leetcode-cn](./leetcode-cn) 中文站点的相关bash脚本
* [leetcode-en](./leetcode-en) 英文站点的相关Bash脚本

两个脚本都需要读取同目录下的auth文件，分别是leetcode的用户名和密码，格式如下

```bash
user_name=your_leetcode_user_name
password=your_leetcode_user_password
```

## 学习资料

* [curl-basic-usage](https://gist.github.com/subfuzion/08c5d85437d5d4f00e58)
