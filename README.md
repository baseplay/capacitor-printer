# @baseplay/capacitor-printer

Prints the current Capacitor WebView through the native print dialog — AirPrint / Save as PDF on iOS, the Android print framework (with its built-in "Save as PDF" printer) on Android, and `window.print()` on the web.

What gets printed is decided by the page's `@media print` stylesheet, exactly as in a desktop browser: hide everything except the printable content, set page breaks, and the native dialog shows the same result.

Supports Capacitor 8 (iOS 15+, Android API 24+). Small on purpose: one method, no dependencies beyond Capacitor.

## Install

The package is installed straight from this repository (it is not published to npm). `dist/` is committed so no build step runs on install. Pin a tag:

```bash
npm install git+https://github.com/baseplay/capacitor-printer.git#v1.0.0
npx cap sync
```

Or in `package.json`:

```json
"@baseplay/capacitor-printer": "git+https://github.com/baseplay/capacitor-printer.git#v1.0.0"
```

The repository is private, so the machine running `npm install` needs GitHub credentials that can read it (an HTTPS credential helper such as `gh auth setup-git`, or an SSH key with the `git+ssh://` URL form).

## Usage

```ts
import { Printer } from '@baseplay/capacitor-printer';

await Printer.printWebView({ name: 'Leg Day' });
```

```css
@media print {
  body > *:not(.print-sheet) { display: none !important; }
  .print-sheet { position: static; }
  tr { break-inside: avoid; }
}
```

### Without importing the package

The JS half of this plugin is just a `registerPlugin` proxy, so an app can reach the native implementation without bundling the package at all — useful when the package is only installed for some builds (per-brand native apps, OTA web bundles built without it):

```ts
import { Capacitor, registerPlugin } from '@capacitor/core';

const Printer = registerPlugin('Printer', {
  web: () => ({ printWebView: async () => window.print() }),
});

const canPrint = Capacitor.isNativePlatform()
  ? Capacitor.isPluginAvailable('Printer')
  : typeof window.print === 'function';
```

## Platform notes

- **iOS**: uses `UIPrintInteractionController` with the WebView's `viewPrintFormatter()`. On iPad the sheet is presented as a popover anchored to the centre of the bridge view controller. The promise resolves when the sheet is dismissed (printed or cancelled) and rejects with code `PRINT_FAILED` on a system error.
- **Android**: uses `PrintManager` with `WebView.createPrintDocumentAdapter(jobName)`. The promise resolves as soon as the job is handed to the system print UI; Android does not report cancellation back. Rejects with code `PRINT_FAILED` if the device has no print service.
- **Web**: `window.print()`. Rejects with an `UNAVAILABLE` error where that function does not exist.

## Release

```bash
npm run build          # regenerates dist/ and the API docs below
git commit -am "..."   # dist/ is tracked on purpose (git-URL installs)
git tag v1.x.y && git push --tags
```

## API

<docgen-index>

* [`printWebView(...)`](#printwebview)
* [Interfaces](#interfaces)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### printWebView(...)

```typescript
printWebView(options?: PrintWebViewOptions | undefined) => Promise<void>
```

Print the current content of the WebView through the native print dialog.

What is printed is decided by the page's `@media print` stylesheet, exactly
as in a desktop browser. The system dialog offers AirPrint and PDF export
on iOS, and includes the built-in "Save as PDF" printer on Android. On the
web this calls `window.print()`.

Resolves once the content has been handed to the system print dialog
(on iOS: once that dialog has been dismissed, whether printed or cancelled).

| Param         | Type                                                                |
| ------------- | ------------------------------------------------------------------- |
| **`options`** | <code><a href="#printwebviewoptions">PrintWebViewOptions</a></code> |

**Since:** 1.0.0

--------------------


### Interfaces


#### PrintWebViewOptions

| Prop       | Type                | Description                                                                                                  | Default                 | Since |
| ---------- | ------------------- | ------------------------------------------------------------------------------------------------------------ | ----------------------- | ----- |
| **`name`** | <code>string</code> | Name of the print job. Shown in the print queue and used as the default file name when the user saves a PDF. | <code>'Document'</code> | 1.0.0 |

</docgen-api>
