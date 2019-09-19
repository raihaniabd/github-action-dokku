# Dokku for GitHub Actions

Deploy an application to your Dokku server over SSH.

## Usage

To use the action add the following lines to your `.github/workflows/main.yml`

```yaml
name: deploy

on: 
  push:
    branches:
      - master

jobs:
  deploy:
    needs: pytest
    runs-on: ubuntu-18.04
    steps:
      - uses: actions/checkout@v1
      - name: Deploy the application
        uses: landmaj/github-action-dokku@master
        with:
          PRIVATE_KEY: ${{ secrets.DOKKU_PRIVATE_KEY }}
          PUBLIC_KEY: ${{ secrets.DOKKU_PUBLIC_KEY }}
          HOST: ${{ secrets.DOKKU_HOST }}
          PROJECT: project-name
```

### Required Variables

* **PRIVATE_KEY**: Your SSH private key, preferably from Secrets.
* **PUBLIC_KEY**: Your SSH public key, preferably from Secrets.
* **HOST**: The host the action will SSH to run the git push command. ie, `your.site.com`.
* **PROJECT**: The project is a Dokku project name.
* **BRANCH**: [OPTIONAL] Repository branch that should be used for deploy, `master` is set by default.

## License

The Dockerfile and associated scripts and documentation in this project are released under the [MIT License](LICENSE).
