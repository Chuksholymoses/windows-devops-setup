#!/bin/bash
# verify-structure.sh - Verify project structure is correct

echo "��� VERIFYING PROJECT STRUCTURE"
echo "================================"

cd /c/cloud-devops-journey-2026

echo "1. Checking root level folders..."
ROOT_FOLDERS=(".devcontainer" "01-foundation" "02-devops-tools" "03-portfolio-projects" "04-career-prep" "docs" "scripts" "sync" "logs" "backups")
for folder in "${ROOT_FOLDERS[@]}"; do
    if [ -d "$folder" ]; then
        echo "   ✅ $folder exists at root"
    else
        echo "   ❌ $folder MISSING from root"
    fi
done

echo ""
echo "2. Checking 04-career-prep content..."
if [ -f "04-career-prep/README.md" ] && [ $(find 04-career-prep -maxdepth 1 -type f | wc -l) -eq 1 ]; then
    echo "   ✅ 04-career-prep clean (only README.md)"
else
    echo "   ❌ 04-career-prep has extra items:"
    ls -la 04-career-prep/
fi

echo ""
echo "3. Checking scripts..."
SCRIPTS=("init-project.sh" "make-executable.sh" "setup-aliases.sh" "sync-environment.sh" "verify-structure.sh")
ALL_GOOD=true
for script in "${SCRIPTS[@]}"; do
    if [ -f "scripts/$script" ] && [ -x "scripts/$script" ]; then
        echo "   ✅ $script exists and executable"
    else
        echo "   ❌ $script missing or not executable"
        ALL_GOOD=false
    fi
done

echo ""
echo "4. Testing environment..."
# Check if we're in right directory
if [ "$(pwd)" = "/c/cloud-devops-journey-2026" ] || [ "$(pwd)" = "/workspaces/cloud-devops-journey-2026" ]; then
    echo "   ✅ In correct project directory"
else
    echo "   ❌ NOT in project directory: $(pwd)"
fi

# Check git
if command -v git &> /dev/null; then
    echo "   ✅ Git is available"
else
    echo "   ❌ Git not found"
fi

echo ""
echo "5. Quick functionality test..."
# Test basic commands
echo "   Testing: ls"
ls > /dev/null 2>&1 && echo "   ✅ ls works" || echo "   ❌ ls failed"

echo "   Testing: git status"
git status --short > /dev/null 2>&1 && echo "   ✅ git status works" || echo "   ❌ git status failed"

echo ""
echo "================================"
if [ "$ALL_GOOD" = true ]; then
    echo "✅ VERIFICATION COMPLETE - SYSTEM READY!"
    echo ""
    echo "��� ALIAS TIPS:"
    echo "   Aliases are set in ~/.bashrc"
    echo "   Run 'source ~/.bashrc' to load them"
    echo "   Or restart your terminal"
else
    echo "⚠️  ISSUES FOUND - Check above"
fi
