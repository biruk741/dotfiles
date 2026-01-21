#!/bin/bash
# Update global package lists with currently installed packages

cd ~/.local/share/chezmoi

echo "Updating global package lists..."

# Update bun-globals.txt
if command -v bun &> /dev/null; then
    echo "Updating bun-globals.txt..."
    bun pm ls -g 2>/dev/null | \
        grep -E "├──|└──" | \
        sed 's/.*── //' | \
        sed 's/@[0-9].*//' | \
        sort > bun-globals.txt
fi

# Update npm-globals.txt
if command -v npm &> /dev/null; then
    echo "Updating npm-globals.txt..."
    npm list -g --depth=0 --json 2>/dev/null | \
        jq -r '.dependencies | keys | .[] | select(. != "npm")' | \
        sort > npm-globals.txt
fi

# Update pnpm-globals.txt
if command -v pnpm &> /dev/null; then
    echo "Updating pnpm-globals.txt..."
    pnpm list -g --depth=0 --json 2>/dev/null | \
        jq -r 'if . then [.[] | .name] else [] end | .[]' | \
        sort > pnpm-globals.txt || echo "# No pnpm globals currently installed" > pnpm-globals.txt
fi

echo "Updated global package lists!"
echo ""
echo "Review changes with: git diff"
echo "Commit with: git add *-globals.txt && git commit -m 'Update global packages'"
