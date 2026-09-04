package co.baseplay.capacitor.printer;

import android.content.Context;
import android.print.PrintAttributes;
import android.print.PrintDocumentAdapter;
import android.print.PrintManager;
import android.webkit.WebView;

/**
 * Print logic, kept independent of the Capacitor bridge so it can be unit
 * tested and reused from other native code.
 */
public class Printer {

    /** Job name used when the caller passes none (matches the JS default). */
    public static final String DEFAULT_JOB_NAME = "Document";

    /**
     * The job name shown in the print UI: the trimmed input, or
     * {@link #DEFAULT_JOB_NAME} when it is missing or blank.
     */
    public String resolveJobName(String name) {
        if (name == null) {
            return DEFAULT_JOB_NAME;
        }
        String trimmed = name.trim();
        return trimmed.isEmpty() ? DEFAULT_JOB_NAME : trimmed;
    }

    /**
     * Hands the WebView's current content to the Android print framework.
     *
     * The WebView's print document adapter applies the page's {@code @media print}
     * stylesheet, and the system print dialog includes the built-in "Save as PDF"
     * printer. Must be called on the UI thread.
     *
     * @param context an Activity context — PrintManager needs one to show its UI
     * @throws IllegalStateException when the device has no print service
     */
    public void printWebView(Context context, WebView webView, String jobName) {
        PrintManager printManager = (PrintManager) context.getSystemService(Context.PRINT_SERVICE);
        if (printManager == null) {
            throw new IllegalStateException("Printing is not available on this device");
        }

        PrintDocumentAdapter adapter = webView.createPrintDocumentAdapter(jobName);
        printManager.print(jobName, adapter, new PrintAttributes.Builder().build());
    }
}
