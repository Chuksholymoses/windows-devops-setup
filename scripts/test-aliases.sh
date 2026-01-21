#!/bin/bash
# test-aliases.sh - Test if aliases are working

echo "í·ª TESTING ALIASES"
echo "=================="

# Source .bashrc to ensure aliases are loaded
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
    echo "âœ… Loaded ~/.bashrc"
else
    echo "âŒ ~/.bashrc not found"
fi

echo ""
echo "Checking aliases..."

# List of aliases to check
declare -A ALIASES=(
    ["gs"]="git status"
    ["ga"]="git add ."
    ["gc"]="git commit -m"
    ["gp"]="git push origin main"
    ["gl"]="git pull origin main"
    ["cdproj"]="cd to project"
)

for alias in "${!ALIASES[@]}"; do
    if alias $alias 2>/dev/null | grep -q "='"; then
        echo "   âœ… $alias is set"
    else
        echo "   âŒ $alias NOT set"
        echo "      To set: Run ./scripts/setup-aliases.sh"
    fi
done

echo ""
echo "Quick test:"
echo -n "   Current dir: "
pwd
echo -n "   Git status: "
git status --short 2>/dev/null | head -1 || echo "not a git repo"

echo ""
echo "=================="
echo "í²¡ If aliases are missing:"
echo "   1. Run: ./scripts/setup-aliases.sh"
echo "   2. Run: source ~/.bashrc"
echo "   3. Or restart terminal"
