package com.r57zone.easynotes

import android.annotation.SuppressLint
import android.annotation.TargetApi
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.webkit.JavascriptInterface
import android.webkit.WebChromeClient
import android.webkit.WebResourceRequest
import android.webkit.WebView
import android.webkit.WebViewClient
import org.json.JSONObject
import java.io.BufferedReader
import java.io.InputStreamReader
import java.io.OutputStreamWriter

class MainActivity : AppCompatActivity() {

    private lateinit var webView: WebView
    private var pendingExportContent: String? = null

    private val REQUEST_CODE_EXPORT = 1001
    private val REQUEST_CODE_IMPORT = 1002

    inner class WebAppInterface {
        @JavascriptInterface
        fun exitApp() {
            runOnUiThread { finish() }
        }

        @JavascriptInterface
        fun saveFile(filename: String, content: String) {
            pendingExportContent = content
            runOnUiThread {
                val intent = Intent(Intent.ACTION_CREATE_DOCUMENT).apply {
                    addCategory(Intent.CATEGORY_OPENABLE)
                    type = "text/plain"
                    putExtra(Intent.EXTRA_TITLE, filename)
                }
                startActivityForResult(intent, REQUEST_CODE_EXPORT)
            }
        }

        @JavascriptInterface
        fun importFile() {
            runOnUiThread {
                val intent = Intent(Intent.ACTION_OPEN_DOCUMENT).apply {
                    addCategory(Intent.CATEGORY_OPENABLE)
                    type = "*/*"
                }
                startActivityForResult(intent, REQUEST_CODE_IMPORT)
            }
        }
    }

    @SuppressLint("SetJavaScriptEnabled")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        supportActionBar?.hide()

        webView = findViewById(R.id.webView)
        webView.settings.javaScriptEnabled = true
        webView.settings.domStorageEnabled = true
        webView.addJavascriptInterface(WebAppInterface(), "Android") // <-- новая строка
        webView.loadUrl("file:///android_asset/index.html")

        val webViewClient: WebViewClient = object : WebViewClient() {
            @Deprecated("Deprecated in Java")
            override fun shouldOverrideUrlLoading(view: WebView, url: String): Boolean {
                if (url.startsWith("http://") || url.startsWith("https://")) {
                    view.context.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(url)))
                    return true
                }
                view.loadUrl(url)
                return false
            }

            @TargetApi(Build.VERSION_CODES.N)
            override fun shouldOverrideUrlLoading(
                view: WebView,
                request: WebResourceRequest
            ): Boolean {
                val url = request.url.toString()
                if (url.startsWith("http://") || url.startsWith("https://")) {
                    view.context.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(url)))
                    return true
                } else {
                    return false
                }
            }
        }

        webView.webViewClient = webViewClient
        webView.webChromeClient = WebChromeClient()
    }

    // Обработка результата выбора файла (сохранение/открытие)
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        if (requestCode == REQUEST_CODE_EXPORT) {
            val uri = if (resultCode == RESULT_OK) data?.data else null
            if (uri != null && pendingExportContent != null) {
                try {
                    contentResolver.openOutputStream(uri)?.use { output ->
                        OutputStreamWriter(output, Charsets.UTF_8).use { writer ->
                            writer.write(pendingExportContent)
                        }
                    }
                    webView.evaluateJavascript("OnExportResult(true);", null)
                } catch (e: Exception) {
                    webView.evaluateJavascript("OnExportResult(false);", null)
                }
            } else {
                webView.evaluateJavascript("OnExportResult(false);", null)
            }
            pendingExportContent = null
        }

        if (requestCode == REQUEST_CODE_IMPORT) {
            val uri = if (resultCode == RESULT_OK) data?.data else null
            if (uri != null) {
                try {
                    val text = contentResolver.openInputStream(uri)?.use { input ->
                        BufferedReader(InputStreamReader(input, Charsets.UTF_8)).readText()
                    } ?: ""
                    val jsonText = JSONObject.quote(text) // безопасно превращает строку в JS-литерал
                    webView.evaluateJavascript("OnImportFileContent($jsonText);", null)
                } catch (e: Exception) {
                    webView.evaluateJavascript("OnImportFileContent(null);", null)
                }
            } else {
                webView.evaluateJavascript("OnImportFileContent(null);", null)
            }
        }
    }

    // Поддержка аппаратной кнопки "назад" — передаём решение в JS
    override fun onBackPressed() {
        webView.evaluateJavascript("OnBackButtonPressed();", null)
    }
}