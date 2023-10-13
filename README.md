
# A minimal container image for running cowsay

The original cowsay is written in Perl so to make it easier we'll use
[Neo-cowsay](https://github.com/Code-Hex/Neo-cowsay).

I'm planning to use this for Tekton experiments.

## Usage

```bash
podman run --rm quay.io/sbaird/ubi9-micro-cowsay cowsay hello
```
