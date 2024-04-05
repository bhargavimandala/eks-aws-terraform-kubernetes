provider "aws" {
    region = "eu-west-1"
}
 
provider "kubernetes" {
  host                   = "aws_eks_cluster.eks.endpoint"
  cluster_ca_certificate = base64decode(var.cert)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", "mbr-eks-play"]
    command     = "aws"
  }
}

provider "helm" {
  alias = "my_cluster"
  kubernetes {
    host                   = "aws_eks_cluster.eks.endpoint"
    cluster_ca_certificate = base64decode(var.cert)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args        = ["eks", "get-token", "--cluster-name", "mbr-eks-play"]
      
    }
  }
} 

terraform {
  required_version = ">= 0.13"

  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}

provider "helm" {
  kubernetes {
    config_path = ""
  }
}

