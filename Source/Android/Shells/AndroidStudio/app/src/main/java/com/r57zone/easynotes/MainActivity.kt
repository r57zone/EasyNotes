package com.r57zone.easynotes

import android.annotation.SuppressLint
import android.annotation.TargetApi
import android.os.Build
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.webkit.WebChromeClient
import android.webkit.WebResourceRequest
import android.webkit.WebView
import android.webkit.WebViewClient


class MainActivity : AppCompatActivity() {
    @SuppressLint("SetJavaScriptEnabled")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main);
        supportActionBar?.hide(); /* Спрятать sidebar */

        val webView = findViewById<WebView>(R.id.webView);
        webView.getSettings().setJavaScriptEnabled(true);
        webView.getSettings().domStorageEnabled = true; // Включение localStorage
        webView.loadUrl("file:///android_asset/index.html");

        val webViewClient: WebViewClient = object : WebViewClient() {
            @Deprecated("Deprecated in Java")
            override fun shouldOverrideUrlLoading(view: WebView, url: String): Boolean {
                view.loadUrl(url)
                return true
            }

            @TargetApi(Build.VERSION_CODES.N)
            override fun shouldOverrideUrlLoading(
                view: WebView,
                request: WebResourceRequest
            ): Boolean {
                view.loadUrl(request.url.toString())
                return true
            }
        }

        webView.setWebViewClient(webViewClient);
        webView.webChromeClient = WebChromeClient(); // Включаение confirm & alert
    }
}