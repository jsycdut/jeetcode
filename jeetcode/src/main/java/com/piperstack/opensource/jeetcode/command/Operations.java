package com.piperstack.opensource.jeetcode.command;

import com.piperstack.opensource.jeetcode.config.Constants;
import com.piperstack.opensource.jeetcode.cookie.LCCookie;
import okhttp3.*;

import java.io.IOException;

public class Operations {
    private OkHttpClient client;
    private boolean isLogin;

    private Operations() {
        this.client = new OkHttpClient.Builder().cookieJar(LCCookie.getInstance()).build();
    }

    public static Operations operations = new Operations();

    public static Operations getInstance() {
        return operations;
    }


    public boolean login(String login, String password) {
        if (null == LCCookie.getInstance().getCsrfToken()) {
            retrieveToken();
        }

        FormBody form = new FormBody.Builder()
                .add("login", login)
                .add("password", password)
                .add("next", "/")
                .add("csrfmiddlewaretoken", LCCookie.getInstance().getCsrfToken())
                .build();

        Request request = new Request.Builder()
                .url(Constants.URL.LOGIN)
                .addHeader(Constants.HEADER.REFERER, Constants.URL.LOGIN)
                .post(form)
                .build();

        try (Response response = client.newCall(request).execute()) {
        } catch (IOException e) {
            e.printStackTrace();
        }

        String session = LCCookie.getInstance().getSession();
        return session != null;
    }

    public boolean retrieveToken() {
        RequestBody bait = RequestBody.create("", Constants.MIME.JSON);
        Request request = new Request.Builder()
                .url(Constants.URL.QUERY)
                .addHeader(Constants.HEADER.REFERER, Constants.URL.HOME)
                .post(bait)
                .build();


        try (Response response = client.newCall(request).execute()) {
            Headers headers = response.headers();
        } catch (IOException e) {
            e.printStackTrace();
        }

        String token = LCCookie.getInstance().getCsrfToken();
        return token != null;
    }

    public String getUserStatus() {
        String json = "{\"operationName\":\"globalData\",\"variables\":{},\"query\":\"query globalData {\\n  feature {\\n    questionTranslation\\n    subscription\\n    signUp\\n    discuss\\n    mockInterview\\n    contest\\n    store\\n    book\\n    chinaProblemDiscuss\\n    socialProviders\\n    studentFooter\\n    cnJobs\\n    __typename\\n  }\\n  userStatus {\\n    isSignedIn\\n    isAdmin\\n    isStaff\\n    isSuperuser\\n    isTranslator\\n    isPremium\\n    isVerified\\n    isPhoneVerified\\n    isWechatVerified\\n    checkedInToday\\n    username\\n    realName\\n    userSlug\\n    groups\\n    jobsCompany {\\n      nameSlug\\n      logo\\n      description\\n      name\\n      legalName\\n      isVerified\\n      permissions {\\n        canInviteUsers\\n        canInviteAllSite\\n        leftInviteTimes\\n        maxVisibleExploredUser\\n        __typename\\n      }\\n      __typename\\n    }\\n    avatar\\n    optedIn\\n    requestRegion\\n    region\\n    activeSessionId\\n    permissions\\n    notificationStatus {\\n      lastModified\\n      numUnread\\n      __typename\\n    }\\n    completedFeatureGuides\\n    useTranslation\\n    __typename\\n  }\\n  siteRegion\\n  chinaHost\\n  websocketUrl\\n}\\n\"}";
        RequestBody body = RequestBody.create(json, Constants.MIME.JSON);

        Request request = new Request.Builder()
                .url(Constants.URL.QUERY)
                .addHeader(Constants.HEADER.REFERER, Constants.URL.HOME)
                .post(body)
                .build();

        try (Response response = client.newCall(request).execute()) {
            System.out.println(response.body().string());
        } catch (IOException ex) {
            ex.printStackTrace();
        }

        return "";
    }
}
