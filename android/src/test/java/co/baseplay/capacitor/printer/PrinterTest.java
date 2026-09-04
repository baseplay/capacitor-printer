package co.baseplay.capacitor.printer;

import static org.junit.Assert.assertEquals;

import org.junit.Test;

public class PrinterTest {

    private final Printer printer = new Printer();

    @Test
    public void resolveJobName_fallsBackToDefault() {
        assertEquals(Printer.DEFAULT_JOB_NAME, printer.resolveJobName(null));
        assertEquals(Printer.DEFAULT_JOB_NAME, printer.resolveJobName(""));
        assertEquals(Printer.DEFAULT_JOB_NAME, printer.resolveJobName("   \n"));
    }

    @Test
    public void resolveJobName_trimsWhitespace() {
        assertEquals("Leg Day", printer.resolveJobName("  Leg Day  "));
    }
}
