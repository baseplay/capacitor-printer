import Foundation
import Capacitor

/// Capacitor bridge for the Printer plugin. The print logic lives in
/// `Printer.swift`; this class only maps plugin calls onto it.
@objc(PrinterPlugin)
public class PrinterPlugin: CAPPlugin, CAPBridgedPlugin {
    public let identifier = "PrinterPlugin"
    public let jsName = "Printer"
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "printWebView", returnType: CAPPluginReturnPromise)
    ]
    private let implementation = Printer()

    @objc func printWebView(_ call: CAPPluginCall) {
        let jobName = implementation.resolveJobName(call.getString("name"))

        DispatchQueue.main.async { [weak self] in
            guard let self = self, let webView = self.bridge?.webView else {
                call.reject("Web view is not available", "WEBVIEW_UNAVAILABLE")
                return
            }

            self.implementation.printWebView(
                webView,
                anchoredTo: self.bridge?.viewController?.view,
                jobName: jobName
            ) { result in
                switch result {
                case .success:
                    call.resolve()
                case .failure(let error):
                    call.reject(error.localizedDescription, "PRINT_FAILED", error)
                }
            }
        }
    }
}
