# DevSecOps Showcase

This project demonstrates a CI/CD pipeline with an integrated security scanner (DevSecOps). The pipeline builds a web application, scans it for vulnerabilities, and prepares it for deployment.

## CI/CD Pipeline

The pipeline, defined in `.github/workflows/ci-pipeline.yml`, includes the following key jobs:

1.  **Build**: Builds the Docker image.
2.  **Scan**: Scans the image for `CRITICAL` or `HIGH` severity vulnerabilities using Trivy. This job acts as a security gate, stopping the pipeline if vulnerabilities are found.
3.  **Push to Registry**: Publishes the image to a container registry, but only if the `scan` job succeeds.
4.  **Manage Infra**: Demonstrates Infrastructure as Code (IaC) by managing a GitHub repository label via Terraform.

## Security Gate: Trivy Scan Results

The security gate ensures that only secure images proceed to deployment.

### Vulnerable Version (`python:3.8-slim`)

An initial scan using an older base image revealed several vulnerabilities, causing the pipeline to fail.

**OS Packages (debian 12.7) - 11 Total (1 CRITICAL, 10 HIGH)**

| Library      | Vulnerability  | Severity | Installed Version | Fixed Version    | Title                                                                  |
| :----------- | :------------- | :------- | :---------------- | :--------------- | :--------------------------------------------------------------------- |
| `libc-bin`   | CVE-2025-4802  | HIGH     | `2.36-9+deb12u8`  | `2.36-9+deb12u11`| `glibc`: static setuid binary `dlopen` may incorrectly search `LD_LIBRARY_PATH` |
| `libexpat1`  | CVE-2023-52425 | HIGH     | `2.5.0-1+deb12u1` | `2.5.0-1+deb12u2`| `expat`: parsing large tokens can trigger a denial of service          |
| `libgnutls30`| CVE-2025-32988 | HIGH     | `3.7.9-2+deb12u3` | `3.7.9-2+deb12u5`| `gnutls`: Vulnerability in GnuTLS `otherName` SAN export               |
| `liblzma5`   | CVE-2025-31115 | HIGH     | `5.4.1-0.2`       | `5.4.1-1`        | `xz`: Heap-use-after-free bug in threaded `.xz` decoder                |
| `libsqlite3-0`| CVE-2025-6965 | CRITICAL | `3.40.1-2`        | `3.40.1-2+deb12u2`| `sqlite`: Integer Truncation in SQLite                                 |
| `perl-base`  | CVE-2023-31484 | HIGH     | `5.36.0-7+deb12u1`| `5.36.0-7+deb12u3`| `perl`: `CPAN.pm` does not verify TLS certificates over HTTPS          |

*(...and 5 other HIGH severity vulnerabilities)*

**Python Packages - 3 Total (3 HIGH)**

| Library        | Vulnerability  | Severity | Installed Version | Fixed Version | Title                                                                    |
| :------------- | :------------- | :------- | :---------------- | :------------ | :----------------------------------------------------------------------- |
| `setuptools`   | CVE-2022-40897 | HIGH     | `57.5.0`          | `65.5.1`      | `pypa-setuptools`: Regular Expression Denial of Service (ReDoS)          |
| `setuptools`   | CVE-2024-6345  | HIGH     | `57.5.0`          | `70.0.0`      | `pypa/setuptools`: Remote code execution via download functions          |
| `setuptools`   | CVE-2025-47273 | HIGH     | `57.5.0`          | `78.1.1`      | `setuptools`: Path Traversal Vulnerability in `PackageIndex`             |

### Secure Version (`python:3.14-slim`)

After updating the `Dockerfile` to a newer, more secure base image, the scan found no critical vulnerabilities, and the pipeline was allowed to continue.

| Target                      | Type       | Vulnerabilities |
| :-------------------------- | :--------- | :-------------- |
| `my-app:latest (debian 13.1)` | `debian`   | 0               |
| `python-pkg`                  | `python-pkg` | 0               |

## Local Deployment

To run the application locally using Kubernetes (e.g., k3s or Docker Desktop):

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/your-username/DevSecOps-Showcase.git
    cd DevSecOps-Showcase
    ```

2.  **Deploy to Kubernetes:**
    ```bash
    kubectl apply -f kubernetes/deployment.yaml
    ```

3.  **Check pod status:**
    ```bash
    kubectl get pods
    ```

4.  **Access the application:**
    Forward the port to your local machine.
    ```bash
    kubectl port-forward deployment/my-secure-app 5000:5000
    ```
    Open [http://localhost:5000](http://localhost:5000) in your browser.

If you find this project helpful, please give it a star on GitHub!