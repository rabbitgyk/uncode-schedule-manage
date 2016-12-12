package com.rabbit.manage.util;

import java.io.IOException;
import java.security.KeyManagementException;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;

import javax.net.ssl.SSLContext;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpUriRequest;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.conn.ssl.TrustStrategy;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.ssl.SSLContextBuilder;
import org.apache.http.util.EntityUtils;

public class HttpClientUtil {

	private static String HTTP = "http";
	private static String HTTPS = "https";
	
	public static String httpPost(String url) throws Exception{
		HttpPost httppost = new HttpPost(url);
		return executeHttp(httppost, getHttpType(url));
	}
	
	public static String httpGet(String url) throws Exception{
		HttpGet httpget = new HttpGet(url);
		return executeHttp(httpget, getHttpType(url));
	}
	
	private static String getHttpType(String url){
		return url.split(":")[0];
	}
	
	/**
	 * 创建ssl的client
	 * @return
	 */
	private static CloseableHttpClient createSSLClientDefault() {
		try {
			SSLContext sslContext = new SSLContextBuilder().loadTrustMaterial(
					null, new TrustStrategy() {
						// 信任所有
						public boolean isTrusted(X509Certificate[] chain,
								String authType) throws CertificateException {
							return true;
						}
					}).build();
			SSLConnectionSocketFactory sslsf = new SSLConnectionSocketFactory(sslContext);
			return HttpClients.custom().setSSLSocketFactory(sslsf).build();
		} catch (KeyManagementException e) {
			e.printStackTrace();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (KeyStoreException e) {
			e.printStackTrace();
		}
		return HttpClients.createDefault();
	}
	
	/**
	 * 执行http/https请求的方法
	 * @param request
	 * @return
	 */
	private static String executeHttp(HttpUriRequest request, String type) throws Exception{
		String result = null;
		CloseableHttpResponse response = null;
		CloseableHttpClient httpclient = null;
		if(type.equals(HTTP)){
			httpclient = HttpClients.createDefault();
		}else if(type.equals(HTTPS)){
			httpclient = createSSLClientDefault();
		}
		try {
			response = httpclient.execute(request);
			HttpEntity myEntity = response.getEntity();  
			result = EntityUtils.toString(myEntity);  
		} catch (Exception e) {
			throw e;
		}finally{
			try {
				response.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return result;
	}
}
