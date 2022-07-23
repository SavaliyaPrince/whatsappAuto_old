package com.whatsapp_auto.app;

import okhttp3.RequestBody;
import okhttp3.ResponseBody;
import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.POST;

public interface APIinterface {

    @POST("incoming")
    Call<ResponseBody> requestAd(@Body() RequestBody message);
}
