package co.baseplay.capacitor.printer;

import android.webkit.WebView;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;

/**
 * Capacitor bridge for the Printer plugin. The print logic lives in
 * {@link Printer}; this class only maps plugin calls onto it.
 */
@CapacitorPlugin(name = "Printer")
public class PrinterPlugin extends Plugin {

    private final Printer implementation = new Printer();

    @PluginMethod
    public void printWebView(PluginCall call) {
        final String jobName = implementation.resolveJobName(call.getString("name"));

        getActivity().runOnUiThread(() -> {
            WebView webView = getBridge().getWebView();
            if (webView == null) {
                call.reject("Web view is not available", "WEBVIEW_UNAVAILABLE");
                return;
            }

            try {
                implementation.printWebView(getContext(), webView, jobName);
                call.resolve();
            } catch (Exception e) {
                call.reject(e.getMessage(), "PRINT_FAILED", e);
            }
        });
    }
}
