terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

provider "github" {
  owner      = split("/", var.github_repo_full)[0]
  repository = split("/", var.github_repo_full)[1]
}

resource "github_issue_label" "demo_label" {
  name        = "terraform: managed"
  description = "This label is managed by Terraform (IaC)."
  color       = "A240EF"
}