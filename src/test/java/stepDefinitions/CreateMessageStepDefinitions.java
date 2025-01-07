package stepDefinitions;

import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.RestAssured;
import io.restassured.response.Response;
import io.restassured.module.jsv.JsonSchemaValidator;
import java.io.File;
import org.junit.Assert;

import java.util.Map;
import static org.hamcrest.Matchers.*;

public class CreateMessageStepDefinitions {
    private String endpoint;
    private Response response;

    @Given("the endpoint {string}")
    public void the_endpoint(String url) {
        endpoint = url;
    }

    @When("customer sends a POST request with the following data:")
    public void customer_sends_a_post_request_to_with_the_following_data(DataTable dataTable) {
        Map<String, String> requestData = dataTable.asMaps().get(0);

        response = RestAssured.given()
                .contentType("application/json")
                .body(requestData)
                .when()
                .post(endpoint);
    }

    @Then("the response status code should be {int}")
    public void response_status_code(int statusCode) {
        Assert.assertEquals(statusCode, response.getStatusCode());
    }

    @Then("the response should contain a valid messageId")
    public void the_response_should_contain_a_valid_messageId() {
        response.then()
                .body("messageid", instanceOf(Integer.class));
    }

    @Then("the response should contain:")
    public void the_response_should_contain(DataTable dataTable) {
        Map<String, String> expectedData = dataTable.asMaps().get(0);

        for (Map.Entry<String, String> entry : expectedData.entrySet()) {
            response.then().body(entry.getKey(), equalTo(entry.getValue()));
        }
    }

    @Then("the response should match the JSON schema")
    public void the_response_should_match_the_json_schema() {
        File schema = new File("src/test/resources/messageschema.json");
        response.then().assertThat().body(JsonSchemaValidator.matchesJsonSchema(schema));
    }

}