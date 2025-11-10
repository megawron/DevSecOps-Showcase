Infrastructure as Code (IaC) - Live Demo
========================================

This directory contains Terraform code to demonstrate Infrastructure as Code (IaC) principles, a core part of DevSecOps.

This is a LIVE Demo, Not a Dry Run
----------------------------------

Unlike a static example, this code is **actively executed** by the manage-infra job in the ci-pipeline.yml.

### What it Does

This code uses the **Terraform GitHub Provider** to manage resources within this repository itself. Specifically, it creates and manages a repository label:

*   **Label Name:** terraform: managed
    
*   **Color:** #A240EF
    
*   **Description:** "This label is managed by Terraform (IaC)."
    

### Why?

This serves as a 100% free, safe, and integrated way to prove that the pipeline can handle infrastructure management. The pipeline authenticates against the GitHub API using the built-in GITHUB\_TOKEN and applies these changes automatically.

You can see the result in the **"Issues" -> "Labels"** tab of this repository.