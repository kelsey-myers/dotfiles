#!/bin/bash

echo "🚀 Setting up dotfiles..."

# Ensure .bashrc is sourced for login shells (fixes VS Code terminal)
echo "🔧 Setting up .bash_profile..."
cat > ~/.bash_profile << 'PROFILE'
# Source .bashrc for login shells
if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
fi
PROFILE

# Git config
echo "⚙️  Configuring git..."
git config --global push.autoSetupRemote true
git config --global pull.rebase true
git config --global rebase.autoStash true

# Add bash customizations
echo "📝 Adding bash aliases and functions..."
cat >> ~/.bashrc << 'EOF'

# Custom Git Aliases
alias pr='gh pr create --web'
alias get-master='git checkout master && git pull'
alias get-main='git checkout main && git pull'

# Custom test runner for running tests with all variations
tatt() {
  if [ -z "$1" ]; then
    echo "Usage: tatt <test_file_path>"
    echo "Example: tatt packages/issues/test/models/issue_test.rb"
    return 1
  fi
  
  local test_path="$1"
  
  echo "========================================"
  echo "Running tests for: $test_path"
  echo "========================================"
  
  echo ""
  echo "1/5: Running with default settings..."
  bin/rails test "$test_path" && \
  
  echo "" && \
  echo "2/5: Running with TEST_ALL_FEATURES=1..." && \
  TEST_ALL_FEATURES=1 bin/rails test "$test_path" && \
  
  echo "" && \
  echo "3/5: Running with MULTI_TENANT_ENTERPRISE=1 TEST_ALL_FEATURES=1..." && \
  MULTI_TENANT_ENTERPRISE=1 TEST_ALL_FEATURES=1 bin/rails test "$test_path" && \
  
  echo "" && \
  echo "4/5: Running with ENTERPRISE=1..." && \
  ENTERPRISE=1 bin/rails test "$test_path" && \
  
  echo "" && \
  echo "5/5: Running with TEST_WITH_ALL_EMUS=1..." && \
  TEST_WITH_ALL_EMUS=1 bin/rails test "$test_path" && \
  
  echo "" && \
  echo "========================================" && \
  echo "✅ All test variations passed!" && \
  echo "========================================"
}
EOF

echo "✅ Dotfiles setup complete!"
