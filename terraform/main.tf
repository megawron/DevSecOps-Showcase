terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

provider "github" {}

resource "github_repository_label" "demo_label" {
  repository = "DevSecOps-Showcase"
  name       = "terraform: managed"
  description = "This label is managed by Terraform (IaC)."
  color      = "A240EF"
}