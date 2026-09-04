import { Printer } from '@baseplay/capacitor-printer';

window.printPage = async () => {
  const name = document.getElementById('jobName').value;
  try {
    await Printer.printWebView({ name });
  } catch (error) {
    console.error('printWebView failed', error);
  }
};
