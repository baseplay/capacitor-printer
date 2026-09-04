import Foundation
import UIKit
import WebKit

/// Print logic, kept independent of the Capacitor bridge so it can be unit
/// tested and reused from other native code.
@objc public class Printer: NSObject {
    /// Job name used when the caller passes none (matches the JS default).
    public static let defaultJobName = "Document"

    /// The job name shown in the print centre: the trimmed input, or
    /// `defaultJobName` when it is missing or blank.
    public func resolveJobName(_ name: String?) -> String {
        let trimmed = name?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        return trimmed.isEmpty ? Printer.defaultJobName : trimmed
    }

    /// Presents the system print sheet for the WebView's current content.
    ///
    /// The WebView's own print formatter is used, so the page's `@media print`
    /// stylesheet decides what is printed. The sheet offers AirPrint and PDF
    /// export. Completes with `true` when the user printed and `false` when
    /// they cancelled. Must be called on the main thread.
    ///
    /// - Parameter anchorView: view the sheet is anchored to on iPad, where it
    ///   is presented as a popover and needs a source rect.
    public func printWebView(
        _ webView: WKWebView,
        anchoredTo anchorView: UIView?,
        jobName: String,
        completion: @escaping (Result<Bool, Error>) -> Void
    ) {
        let printInfo = UIPrintInfo(dictionary: nil)
        printInfo.jobName = jobName
        printInfo.outputType = .general

        let controller = UIPrintInteractionController.shared
        controller.printInfo = printInfo
        controller.showsNumberOfCopies = true
        controller.printFormatter = webView.viewPrintFormatter()

        let handler: UIPrintInteractionController.CompletionHandler = { _, completed, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(completed))
            }
        }

        if UIDevice.current.userInterfaceIdiom == .pad, let anchorView = anchorView {
            let anchor = CGRect(x: anchorView.bounds.midX, y: anchorView.bounds.midY, width: 1, height: 1)
            controller.present(from: anchor, in: anchorView, animated: true, completionHandler: handler)
        } else {
            controller.present(animated: true, completionHandler: handler)
        }
    }
}
