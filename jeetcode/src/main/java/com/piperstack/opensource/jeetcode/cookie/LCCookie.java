package com.piperstack.opensource.jeetcode.cookie;

import okhttp3.Cookie;
import okhttp3.CookieJar;
import okhttp3.HttpUrl;
import org.jetbrains.annotations.NotNull;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.ArrayList;
/**
 * LCCookie => Leetcode Cookie, saving cookies when visit leetcode-cn.com
 */
public class LCCookie implements CookieJar {
    final static LCCookie lcCookie = new LCCookie();
    final static Map<String, Map<String, Cookie>> cookies = new HashMap<>();
    private String token;

    // leetcode-cn.com will set cookie named "LEETCODE_SESSION" after you passed the login challenge
    private String sessionId;

    public static LCCookie getInstance() {
        return lcCookie;
    }

    private LCCookie() {
    }

    @NotNull
    @Override
    public List<Cookie> loadForRequest(@NotNull HttpUrl httpUrl) {
        return null == cookies.get(httpUrl.host()) ? Collections.<Cookie>emptyList() : new ArrayList<Cookie>(cookies.get(httpUrl.host()).values());
    }

    @Override
    public void saveFromResponse(@NotNull HttpUrl httpUrl, @NotNull List<Cookie> list) {
        if (!cookies.containsKey(httpUrl.host())) cookies.put(httpUrl.host(), new HashMap<String, Cookie>());

        for (Cookie cookie : list) {
            if (cookie.name().equals("csrftoken")) {
                this.token = cookie.value();
            }

            if (cookie.name().equals("LEETCODE_SESSION")) {
                this.sessionId = cookie.value();
            }

            cookies.get(httpUrl.host()).put(cookie.name(), cookie);
        }
    }

    public String getCsrfToken() {
        return this.token;
    }

    public String getSession() {
        return this.sessionId;
    }

    public List<Cookie> getCookies(String host) {
        return new ArrayList<>(cookies.get(host).values());
    }
}
