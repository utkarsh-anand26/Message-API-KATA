package hooks;

import io.cucumber.java.Before;
import io.cucumber.java.After;

public class Hooks {
    @Before
    public void setUp() {
        System.out.println("Starting the test...");
    }

    @After
    public void tearDown() {
        System.out.println("Test completed.");
    }
}
