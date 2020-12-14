//package com.hobby.sns;
//
//import com.github.scribejava.core.builder.api.DefaultApi20;
//
//public class GoogleLoginApi extends DefaultApi20{
// 
//    protected GoogleLoginApi(){
//    }
// 
//    private static class InstanceHolder{
//        private static final GoogleLoginApi INSTANCE = new GoogleLoginApi();
//    }
// 
// 
//    public static GoogleLoginApi instance(){
//        return InstanceHolder.INSTANCE;
//    }
// 
//    @Override
//    public String getAccessTokenEndpoint() {
//        return "https://accounts.google.com/o/oauth2/auth";
//    }                   
// 
//    @Override
//    protected String getAuthorizationBaseUrl() {
//        return "https://oauth2.googleapis.com/token";
//    }   
// 
//}
// 
