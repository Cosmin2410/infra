.PHONY: help edit-vault-prod edit-vault-staging edit-vault-dev view-vault-prod view-vault-staging view-vault-dev

# Default target
help:
	@echo "LazyFiller Infrastructure - Makefile Commands"
	@echo ""
	@echo "Vault Management:"
	@echo "  make edit-vault-prod      Edit production vault file"
	@echo "  make edit-vault-staging   Edit staging vault file"
	@echo "  make edit-vault-dev       Edit development vault file"
	@echo "  make view-vault-prod      View production vault (read-only)"
	@echo "  make view-vault-staging   View staging vault (read-only)"
	@echo "  make view-vault-dev       View development vault (read-only)"
	@echo ""
	@echo "Deployment:"
	@echo "  make deploy-staging       Deploy configs to staging"
	@echo "  make deploy-prod          Deploy configs to production"
	@echo "  make deploy-dev           Deploy configs to development"
	@echo "  make check-staging        Dry-run deployment to staging"
	@echo "  make check-prod           Dry-run deployment to production"
	@echo "  make check-dev            Dry-run deployment to development"

# Edit vault files
edit-vault-prod:
	@echo "Editing production vault..."
	@EDITOR=nvim ansible-vault edit inventory/production/group_vars/all/vault.yml

edit-vault-staging:
	@echo "Editing staging vault..."
	@EDITOR=nvim ansible-vault edit inventory/staging/group_vars/all/vault.yml

edit-vault-dev:
	@echo "Editing development vault..."
	@EDITOR=nvim ansible-vault edit inventory/development/group_vars/all/vault.yml

# View vault files (read-only)
view-vault-prod:
	@echo "Viewing production vault (read-only)..."
	@ansible-vault view inventory/production/group_vars/all/vault.yml

view-vault-staging:
	@echo "Viewing staging vault (read-only)..."
	@ansible-vault view inventory/staging/group_vars/all/vault.yml

view-vault-dev:
	@echo "Viewing development vault (read-only)..."
	@ansible-vault view inventory/development/group_vars/all/vault.yml

# Deployment commands
deploy-staging:
	@echo "Deploying to staging..."
	@ansible-playbook -i inventory/staging playbooks/deploy-configs.yml

deploy-prod:
	@echo "Deploying to production..."
	@ansible-playbook -i inventory/production playbooks/deploy-configs.yml

deploy-dev:
	@echo "Deploying to development..."
	@ansible-playbook -i inventory/development playbooks/deploy-configs.yml

check-staging:
	@echo "Dry-run deployment to staging..."
	@ansible-playbook -i inventory/staging playbooks/deploy-configs.yml --check --diff

check-prod:
	@echo "Dry-run deployment to production..."
	@ansible-playbook -i inventory/production playbooks/deploy-configs.yml --check --diff

check-dev:
	@echo "Dry-run deployment to development..."
	@ansible-playbook -i inventory/development playbooks/deploy-configs.yml --check --diff
