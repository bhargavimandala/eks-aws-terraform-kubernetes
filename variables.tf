variable "vpc-cidr"{
    default="10.10.0.0/20"
 }

 variable "subnet1-cidr"{
    default="10.10.3.0/24"
 }
 
 variable "subnet2-cidr"{
    default="10.10.2.0/24"
 }
 variable "subnet-az-1"{
    default= "eu-west-1a"
 }
 variable "subnet-az-2"{
    default= "eu-west-1b"
 }

 /* variable "subnet_ids" {
  type = list
} */

variable "cert" {
   default = ""