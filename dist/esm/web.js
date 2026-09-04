import { WebPlugin } from '@capacitor/core';
export class PrinterWeb extends WebPlugin {
    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    async printWebView(_options) {
        if (typeof window === 'undefined' || typeof window.print !== 'function') {
            throw this.unavailable('Printing is not available in this browser.');
        }
        // The browser's print dialog names the job after the document title and
        // offers "Save as PDF" itself, so `name` has no web counterpart.
        window.print();
    }
}
//# sourceMappingURL=web.js.map