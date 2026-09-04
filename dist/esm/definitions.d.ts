export interface PrinterPlugin {
    /**
     * Print the current content of the WebView through the native print dialog.
     *
     * What is printed is decided by the page's `@media print` stylesheet, exactly
     * as in a desktop browser. The system dialog offers AirPrint and PDF export
     * on iOS, and includes the built-in "Save as PDF" printer on Android. On the
     * web this calls `window.print()`.
     *
     * Resolves once the content has been handed to the system print dialog
     * (on iOS: once that dialog has been dismissed, whether printed or cancelled).
     *
     * @since 1.0.0
     */
    printWebView(options?: PrintWebViewOptions): Promise<void>;
}
export interface PrintWebViewOptions {
    /**
     * Name of the print job. Shown in the print queue and used as the default
     * file name when the user saves a PDF.
     *
     * @default 'Document'
     * @since 1.0.0
     */
    name?: string;
}
