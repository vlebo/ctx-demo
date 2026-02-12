# ctx_ Demo Environment

A self-contained Docker environment for demonstrating ctx_ features.

## Quick Start

```bash
# Build the demo image
make build

# Run interactive demo
make demo

# Or start a shell to try commands yourself
make run
```

## What's Included

This demo includes:
- ✅ ctx_ pre-installed
- ✅ 6 demo contexts (dev, staging, prod, GCP, Azure, Nomad)
- ✅ Interactive guided demo script
- ✅ Production safeguards configured
- ✅ Multi-cloud examples
- ✅ HashiCorp stack integration

## Demo Contexts

This demo includes 6 pre-configured contexts demonstrating different features:

### acme-dev
Development environment with AWS, Kubernetes, SSH tunnels, VPN, and custom environment variables.
Includes PostgreSQL and Redis tunnel configurations.

### acme-staging
Staging environment with similar configuration to dev but staging-specific endpoints and settings.

### acme-prod
Production environment with **production safeguards enabled**.
- Requires `--confirm` flag to switch
- Uses aws-vault for security
- Auto-connects VPN
- Higher connection pool sizes

### acme-gcp
Google Cloud Platform multi-cloud example.
Demonstrates GKE integration and Cloud SQL tunnels.

### acme-azure
Microsoft Azure multi-cloud example.
Shows AKS integration and Azure-specific configurations.

### acme-nomad
HashiCorp stack demonstration.
Integrates Nomad, Consul, and Vault configurations.

## Usage

### Guided Demo

Run the interactive demo script that walks through all features:

```bash
make demo
```

This will guide you through:
1. Listing contexts
2. Viewing context details
3. Switching contexts
4. Verifying environment variables
5. Testing production safeguards
6. Deactivating contexts

### Manual Exploration

Start an interactive shell:

```bash
make run
```

Then try these commands:

```bash
# List available contexts
ctx list

# View context configuration
ctx show acme-dev

# Switch to dev environment
ctx use acme-dev

# Check current context
ctx

# Verify environment variables
echo $CTX_CURRENT
echo $ENV_NAME
echo $API_URL

# Switch to staging
ctx use acme-staging

# Try to switch to production (will fail)
ctx use acme-prod

# Switch to production with confirmation
ctx use acme-prod --confirm
# Type 'yes' when prompted

# Deactivate context
ctx deactivate
```

## Makefile Targets

| Target | Description |
|--------|-------------|
| `make build` | Build the demo Docker image |
| `make run` | Run interactive shell with ctx |
| `make demo` | Run guided demo script |
| `make clean` | Remove demo image and containers |
| `make rebuild` | Clean and rebuild image |
| `make test` | Quick test that ctx is working |
| `make help` | Show all available targets |

## Demo Script Steps

The guided demo (`make demo`) covers:

**Step 1:** List available contexts
```bash
ctx list
```

**Step 2:** Check current context (should be none initially)
```bash
ctx
```

**Step 3:** View context configuration
```bash
ctx show acme-dev
```

**Step 4:** Switch to development
```bash
ctx use acme-dev
```

**Step 5:** Verify environment variables are set correctly
```bash
echo $CTX_CURRENT  # acme-dev
echo $ENV_NAME     # development
echo $API_URL      # https://api.dev.example.com
```

**Step 6:** Switch to staging and see variables update
```bash
ctx use acme-staging
echo $ENV_NAME     # staging
```

**Step 7:** Production safeguard - try without --confirm (fails)
```bash
ctx use acme-prod  # Error: requires --confirm
```

**Step 8:** Production with confirmation
```bash
ctx use acme-prod --confirm
# Prompts: Type 'yes' to confirm
```

**Step 9:** Deactivate context
```bash
ctx deactivate
```

## Context Files

Context YAML files are in `./contexts/`:

All 6 contexts are pre-configured with realistic examples including:
- AWS/GCP/Azure cloud configurations
- Kubernetes cluster settings
- SSH bastion and tunnel configurations
- VPN settings (Wireguard)
- Custom environment variables
- Git author configuration
- Network proxy settings

**Example snippet from acme-dev.yaml:**
```yaml
name: acme-dev
description: ACME Corp development environment
environment: development

aws:
  profile: acme-dev
  region: us-east-1

kubernetes:
  context: dev-cluster
  namespace: default

tunnels:
  - name: postgres
    remote_host: db.dev.internal
    remote_port: 5432
    local_port: 5432

env:
  API_URL: https://api.dev.acme.com
  LOG_LEVEL: debug
```

View the complete context files in `./contexts/` directory.

## Customizing the Demo

### Add Your Own Contexts

1. Create a new YAML file in `./contexts/`:
```bash
cat > contexts/my-context.yaml << EOF
name: my-context
environment: development
env:
  MY_VAR: my_value
EOF
```

2. Rebuild and run:
```bash
make rebuild
make run
```

### Modify Existing Contexts

Edit any `.yaml` file in `./contexts/` directory, then rebuild:

```bash
make rebuild
make run
```

## Architecture

```
ctx-demo/
├── Dockerfile              # Container definition
├── Makefile               # Build and run commands
├── README.md              # This file
├── QUICKSTART.md          # 60-second getting started
├── DEMO_STEPS.md          # Presenter guide
├── contexts/              # Demo context configurations
│   ├── acme-dev.yaml      # Development (AWS + K8s + tunnels)
│   ├── acme-staging.yaml  # Staging
│   ├── acme-prod.yaml     # Production (safeguarded)
│   ├── acme-gcp.yaml      # Google Cloud Platform
│   ├── acme-azure.yaml    # Microsoft Azure
│   └── acme-nomad.yaml    # HashiCorp stack
└── scripts/
    ├── demo.sh            # Interactive demo script
    └── bashrc             # Shell configuration
```

## Requirements

- Docker
- Make (optional, but recommended)

### Without Make

If you don't have `make`, run Docker commands directly:

```bash
# Build
docker build -t ctx-demo .

# Run interactive shell
docker run -it --rm \
  -v $(pwd)/contexts:/home/demo/.config/ctx/contexts:ro \
  ctx-demo /bin/bash

# Run guided demo
docker run -it --rm \
  -v $(pwd)/contexts:/home/demo/.config/ctx/contexts:ro \
  ctx-demo /bin/bash /home/demo/demo.sh
```

## Troubleshooting

### "ctx: command not found"

Make sure the image built successfully:
```bash
make test
```

### Contexts not loading

Check that contexts directory is mounted:
```bash
docker run --rm ctx-demo ls -la /home/demo/.config/ctx/contexts/
```

### Production safeguard not working

Ensure the context has `environment: production` in the YAML:
```bash
grep environment contexts/acme-prod.yaml
```

## Learn More

- **GitHub:** https://github.com/vlebo/ctx
- **Documentation:** https://vlebo.github.io/ctx/

## What's Next?

After trying this demo:
1. Install ctx on your system
2. Create contexts for your environments
3. Integrate with your workflow
4. Share with your team

## License

MIT License - Same as ctx_ itself
