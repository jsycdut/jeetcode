package com.piperstack.opensource.jeetcode.cookie;

import okhttp3.*;
import org.jetbrains.annotations.NotNull;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.*;

import static org.junit.Assert.assertNotNull;

public class LcCookieTest {
    LCCookie cookieJar;
    OkHttpClient client;
    String urlReturnCookie;
    MediaType json;
    String host;


    @Before
    public void setup() {
        cookieJar = LCCookie.getInstance();
        client = new OkHttpClient.Builder()
                .cookieJar(cookieJar)
                .build();
        urlReturnCookie = "https://leetcode-cn.com/graphql/";
        host = "https://leetcode-cn.com/";
        json = MediaType.parse("application/json");
    }

    @Test
    public void testLoadingAndSavingCookie() {
        StringBuilder content = new StringBuilder();
        try (BufferedInputStream fis = new BufferedInputStream(new FileInputStream("json/fetch_cookie"))) {
            byte[] data = new byte[1024];
            while (fis.read(data) != -1) {
                content.append(new String(data));
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        RequestBody requestBody = RequestBody.create(content.toString(), json);
        Request request = new Request.Builder()
                .url(urlReturnCookie)
                .post(requestBody)
                .addHeader("referer", host)
                .build();

        try (Response response = client.newCall(request).execute()) {
            Headers headers = response.headers();
            for (int i = 0; i < headers.size(); i++) {
                System.out.println(headers.name(i) + " " + headers.value(i));
            }
            System.out.println();
            String body = response.body().string();
            System.out.println(body);
        } catch (IOException e) {
            e.printStackTrace();
        }

        try (Response r = client.newCall(request).execute()) {
        } catch (Exception e) {

        }
    }

    @After
    public void destroy() {

    }
}
