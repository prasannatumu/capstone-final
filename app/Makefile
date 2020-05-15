## The Makefile includes instructions on environment setup and lint tests
# Install dependencies in requirements.txt
# Dockerfile should pass hadolint


lint:
        # See local hadolint install instructions:   https://github.com/hadolint/hadolint
        # This is linter for Dockerfiles
		hadolint Dockerfile
		tidy -q -e *.html