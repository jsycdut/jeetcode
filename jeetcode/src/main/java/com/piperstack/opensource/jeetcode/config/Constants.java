package com.piperstack.opensource.jeetcode.config;

import okhttp3.MediaType;

public class Constants {
    public static class URL {
        public static final String HOST = "leetcode-cn.com";
        public static final String HOME = "https://leetcode-cn.com/";
        public static final String QUERY = "https://leetcode-cn.com/graphql/";
        public static final String LOGIN = "https://leetcode-cn.com/accounts/login/";
    }

    public static class MIME {
        public static MediaType JSON = MediaType.parse("application/json");
    }

    public static class HEADER {
        public static final String REFERER = "referer";
    }
}
