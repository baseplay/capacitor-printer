var capacitorPrinter = (function (exports, core) {
    'use strict';

    const Printer = core.registerPlugin('Printer', {
        web: () => Promise.resolve().then(function () { return web; }).then((m) => new m.PrinterWeb()),
    });

    class PrinterWeb extends core.WebPlugin {
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

    var web = /*#__PURE__*/Object.freeze({
        __proto__: null,
        PrinterWeb: PrinterWeb
    });

    exports.Printer = Printer;

    return exports;

})({}, capacitorExports);
//# sourceMappingURL=plugin.js.map
