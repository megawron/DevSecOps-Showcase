terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

variable "github_repo_full" {
  type        = string
  description = "The full repository name, e.g., 'owner/repo'."
}

provider "github" {
  owner = split("/", var.github_repo_full)[0]
}

resource "github_issue_label" "demo_label" {
  repository  = split("/", var.github_repo_full)[1]
  name        = "terraform: managed"
  description = "This label is managed by Terraform (IaC)."
  color       = "A240EF"
}