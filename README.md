# ci-scripts

Collection of reusable build and deploy scripts.

Alternative for the ci part from CICD.

No need to this repo as a submodule. Adding the as a shallow clone
is sufficient.

Example for a `.gitlab-cu.yaml` configuration:

```yaml
variables:
  SCRIPTS_REPO: https://gitlab.solvinity.net/shared-services/docker/scripts/ci-scripts
before_script:
  - export SCRIPTS_DIR=$(mktemp -d)
  - git clone -q --depth 1 "${SCRIPTS_REPO}" "${SCRIPTS_DIR}"
  ```

## Helm build and deploy repository

Generic chart definition and values are in charts/<chart>.

Environment (DTAP or customer) specific configuerations go into deploy/<environment>/<chart>.yaml.

```text
.
├── README.md
├── charts
│   └── <chart>
│       ├── Chart.yaml
│       ├── templates
│       │   ├── ...
│       │   ├── ...
│       └── values.yaml
├── deploy
│   ├── <environment 1>
│   │   └── <chart>.yaml
│   ├── <environment 2>
│   │   └── <chart>yaml
│   └── <environment 3>
│       └── <chart>.yaml
├── kubernetes (will be generated)
│   ├── <environment 1>
│   │   └── <chart>.yaml
│   ├── <environment 2>
│   │   └── <chart>yaml
│   └── <environment 3>
│       └── <chart>.yaml
```