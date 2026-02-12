#!/bin/bash
# ctx_ Interactive Demo Script

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Initialize ctx shell integration
eval "$(ctx shell-hook bash)"

clear

echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║              ctx_ Interactive Demo                           ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "This demo will guide you through the basic features of ctx_"
echo -e "Press ${GREEN}ENTER${NC} after each step to continue..."
echo ""
read -r

# Step 1: List contexts
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}Step 1: List available contexts${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "Command: ${YELLOW}ctx list${NC}"
echo ""
ctx list
echo ""
read -r

# Step 2: Show current context
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}Step 2: Check current context${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "Command: ${YELLOW}ctx${NC}"
echo ""
ctx || echo -e "${YELLOW}No active context${NC}"
echo ""
read -r

# Step 3: View context details
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}Step 3: View context configuration${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "Command: ${YELLOW}ctx show acme-dev${NC}"
echo ""
ctx show acme-dev
echo ""
read -r

# Step 4: Switch to dev
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}Step 4: Switch to development environment${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "Command: ${YELLOW}ctx use acme-dev${NC}"
echo ""
ctx use acme-dev
echo ""
read -r

# Step 5: Verify environment variables
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}Step 5: Verify environment variables are set${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "Check environment variables:"
echo ""
echo -e "${YELLOW}CTX_CURRENT:${NC} $CTX_CURRENT"
echo -e "${YELLOW}CTX_ENVIRONMENT:${NC} $CTX_ENVIRONMENT"
echo -e "${YELLOW}API_URL:${NC} $API_URL"
echo -e "${YELLOW}LOG_LEVEL:${NC} $LOG_LEVEL"
echo -e "${YELLOW}SENTRY_ENVIRONMENT:${NC} $SENTRY_ENVIRONMENT"
echo ""
read -r

# Step 6: Switch to staging
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}Step 6: Switch to staging environment${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "Command: ${YELLOW}ctx use acme-staging${NC}"
echo ""
ctx use acme-staging
echo ""
echo -e "Environment variables updated:"
echo ""
echo -e "${YELLOW}CTX_CURRENT:${NC} $CTX_CURRENT"
echo -e "${YELLOW}CTX_ENVIRONMENT:${NC} $CTX_ENVIRONMENT"
echo -e "${YELLOW}API_URL:${NC} $API_URL"
echo -e "${YELLOW}LOG_LEVEL:${NC} $LOG_LEVEL"
echo ""
read -r

# Step 7: Production safeguard (should fail)
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}Step 7: Production safeguard (without --confirm)${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "Command: ${YELLOW}ctx use acme-prod${NC}"
echo ""
echo -e "${RED}This should fail - production requires --confirm flag:${NC}"
echo ""
ctx use acme-prod || echo -e "${GREEN}✓ Safeguard working! Cannot switch to production without --confirm${NC}"
echo ""
read -r

# Step 8: Production with confirm
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}Step 8: Switch to production (with --confirm)${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "Command: ${YELLOW}ctx use acme-prod --confirm${NC}"
echo ""
echo -e "${YELLOW}Type 'yes' when prompted...${NC}"
echo ""
ctx use acme-prod --confirm
echo ""
echo -e "Environment variables updated to production:"
echo ""
echo -e "${YELLOW}CTX_CURRENT:${NC} $CTX_CURRENT"
echo -e "${YELLOW}CTX_ENVIRONMENT:${NC} $CTX_ENVIRONMENT"
echo -e "${YELLOW}API_URL:${NC} $API_URL"
echo -e "${YELLOW}LOG_LEVEL:${NC} $LOG_LEVEL"
echo ""
read -r

# Step 9: Deactivate
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}Step 9: Deactivate context${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "Command: ${YELLOW}ctx deactivate${NC}"
echo ""
ctx deactivate
echo ""
echo -e "Verify context is cleared:"
echo ""
ctx || echo -e "${GREEN}✓ No active context${NC}"
echo ""
echo -e "${YELLOW}CTX_CURRENT:${NC} ${CTX_CURRENT:-(empty)}"
echo -e "${YELLOW}API_URL:${NC} ${API_URL:-(empty)}"
echo ""
read -r

# Summary
clear
echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║              Demo Complete!                                   ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "You've learned:"
echo -e "  ${GREEN}✓${NC} How to list contexts"
echo -e "  ${GREEN}✓${NC} How to view context details"
echo -e "  ${GREEN}✓${NC} How to switch between contexts"
echo -e "  ${GREEN}✓${NC} How environment variables are managed"
echo -e "  ${GREEN}✓${NC} How production safeguards work"
echo -e "  ${GREEN}✓${NC} How to deactivate contexts"
echo ""
echo -e "${YELLOW}Next Steps:${NC}"
echo -e "  • Try the commands yourself in this shell"
echo -e "  • Create your own contexts"
echo -e "  • Check out: https://github.com/vlebo/ctx"
echo ""
echo -e "Type ${GREEN}exit${NC} to leave the demo container"
echo ""
