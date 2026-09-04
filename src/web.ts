import { WebPlugin } from '@capacitor/core';

import type { PrinterPlugin, PrintWebViewOptions } from './definitions';

export class PrinterWeb extends WebPlugin implements PrinterPlugin {
  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  async printWebView(_options?: PrintWebViewOptions): Promise<void> {
    if (typeof window === 'undefined' || typeof window.print !== 'function') {
      throw this.unavailable('Printing is not available in this browser.');
    }
    // The browser's print dialog names the job after the document title and
    // offers "Save as PDF" itself, so `name` has no web counterpart.
    window.print();
  }
}
