import { WebPlugin } from '@capacitor/core';
import type { PrinterPlugin, PrintWebViewOptions } from './definitions';
export declare class PrinterWeb extends WebPlugin implements PrinterPlugin {
    printWebView(_options?: PrintWebViewOptions): Promise<void>;
}
