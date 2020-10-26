# User variable
variable "environment" {
  type    = string # any, number, bool, list, map, set , object, tuple, string
  default = "DEV"
}

# User variable as a list
variable "names" {
  default = ["kannan_muthlali", "kutti_shrank", "parole_vasu"]
}

# Provider info
provider "aws" {
  region  = "us-east-1"
  version = "~> 2.46"
}

# Define IAM user
resource "aws_iam_user" "my_iam_users" {
  
  ## Note : A simple cpunt and name will result in a list which will cause confusion while tryitg to add an alelemtn as each time the resounrces will be recreated. Altenragte approach given below and thsi is commented out
  
  #count = length(var.names)
  #name  = "${var.environment}_${var.names[count.index]}"
  

  #Note : The belwo method will allow for assigning the nbame as teh index key instead of 0,1,2 etc. 
  for_each = toset(var.names)   // convert list to a set
  #name = each.value // now assign that set to var name
  name = "${var.environment}_${each.value}" // now assign that set to var using values in the terraform.tfvars file

}



