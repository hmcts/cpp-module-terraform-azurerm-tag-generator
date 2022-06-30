package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

type NLContext struct {
	Name             string            `json:"name"`
	Owner            string            `json:"owner"`
	Costcode         string            `json:"costcode"`
	Version          string            `json:"version"`
	Application      string            `json:"application"`
	Type             string            `json:"type"`
	Environment      string            `json:"environment"`
	Role             string            `json:"role"`
	Spot_enabled     string            `json:"spot_enabled"`
	Persistence      string            `json:"persistence"`
	AdditionalTags   map[string]string `json:"additional_tags"`
	AdditionalTagMap map[string]string `json:"additional_tag_map"`
}

// Test the terraform ASG Resource Usage
func TestAsgResource(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		// The path to where the Terraform code is located
		TerraformDir: "../../examples/typical_resource",
		Upgrade:      true,
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	expectedTags := NLContext{
		Name:         "cpp-platform-dev-bastion1-linux",
		Application:  "platform",
		Owner:        "terratest",
		Costcode:     "devops",
		Version:      "v0.0.1",
		Type:         "linux",
		Environment:  "dev",
		Role:         "webapp",
		Persistence:  "False",
	}

	// Order ["application", "environment", "role", "attribute", "type"]
	expectedResourceId := "cpp-platform-dev-bastion1-linux"

	tagSetTags := terraform.OutputMap(t, terraformOptions, "tag_set1_tags")
	resourceId := terraform.Output(t, terraformOptions, "resource1_id")

	// Verify we're getting back the outputs we expect
	assertTagOutputs(
		t,
		terraformOptions,
		expectedTags,
		expectedResourceId,
		tagSetTags,
		resourceId,
	)
}

// Test the Terraform typical resource deployment.
func TestTypicalResource(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		// The path to where the Terraform code is located
		TerraformDir: "../../examples/typical_resource",
		Upgrade:      true,
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	expectedTags1 := NLContext{
		Name:         "cpp-platform-dev-bastion1-linux",
		Application:  "platform",
		Owner:        "terratest",
		Costcode:     "devops",
		Version:      "v0.0.1",
		Type:         "linux",
		Environment:  "dev",
		Role:         "webapp",
		Spot_enabled: "",
		Persistence:  "False",
	}

	expectedTags2 := NLContext{
		Name:         "cpp-platform-dev-splunklogging-blobstorage",
		Application:  "platform",
		Owner:        "terratest",
		Costcode:     "devops",
		Version:      "v0.0.1",
		Type:         "blobstorage",
		Environment:  "dev",
		Role:         "sensitive_datastore",
		Spot_enabled: "",
		Persistence:  "False",
	}

	// Order ["application", "environment", "role", "attribute", type"]
	expectedResource1Id := "cpp-platform-dev-bastion1-linux"
	expectedResource2Id := "cpp-platform-dev-splunklogging-blobstorage"

	// Run `terraform output` to get the value of the output variables
	tagSet1Tags := terraform.OutputMap(t, terraformOptions, "tag_set1_tags")
	tagSet2Tags := terraform.OutputMap(t, terraformOptions, "tag_set2_tags")
	resource1Id := terraform.Output(t, terraformOptions, "resource1_id")
	resource2Id := terraform.Output(t, terraformOptions, "resource2_id")

	assertTagOutputs(
		t,
		terraformOptions,
		expectedTags1,
		expectedResource1Id,
		tagSet1Tags,
		resource1Id,
	)

	assertTagOutputs(
		t,
		terraformOptions,
		expectedTags2,
		expectedResource2Id,
		tagSet2Tags,
		resource2Id,
	)

}

func assertTagOutputs(t *testing.T,
	terraformOptions *terraform.Options,
	expectedTags NLContext,
	expectedRsrcNm string,
	tagOutputMap map[string]string,
	rsrcOutputNm string) {

	expectedResource1Id := expectedRsrcNm

	// Verify we're getting back the outputs we expect
	assert.Equal(t, expectedTags.Name, tagOutputMap["Name"], "Name tag should match name")
	assert.Equal(t, expectedTags.Application, tagOutputMap["Application"], "Application tag should match application")
	assert.Equal(t, expectedTags.Owner, tagOutputMap["Owner"], "Owner tag should match owner")
	assert.Equal(t, expectedTags.Costcode, tagOutputMap["Costcode"], "Costcode tag should match costcode")
	assert.Equal(t, expectedTags.Version, tagOutputMap["Version"], "Version tag should match version")
	assert.Equal(t, expectedTags.Type, tagOutputMap["Type"], "Type tag should match type")
	assert.Equal(t, expectedTags.Environment, tagOutputMap["Environment"], "Environment tag should match environment")
	assert.Equal(t, expectedTags.Role, tagOutputMap["Role"], "Role tag should match role")
	assert.Equal(t, expectedTags.Spot_enabled, tagOutputMap["Spot_enabled"], "Spot enabled tag should match spot enabled")
	assert.Equal(t, expectedTags.Persistence, tagOutputMap["Persistence"], "Persistene tag should match persistence")
	assert.Equal(t, expectedResource1Id, rsrcOutputNm, "Resource Id should match Expectation")
}
