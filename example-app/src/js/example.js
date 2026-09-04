import { Printer } from '@baseplay/capacitor-printer';

window.testEcho = () => {
    const inputValue = document.getElementById("echoInput").value;
    Printer.echo({ value: inputValue })
}
