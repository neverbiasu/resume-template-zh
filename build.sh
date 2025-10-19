#!/usr/bin/env bash
# build-with-bib.sh - Build resume with BibTeX support
# Usage: ./build-with-bib.sh

set -e  # Exit on error

cd "$(dirname "$0")" || exit 1

echo "🔨 Cleaning build artifacts..."
rm -f main.aux main.log main.out main.pdf main.bbl main.blg *.aux 2>/dev/null || true

echo "📖 Running xelatex (first pass)..."
if ! xelatex -interaction=nonstopmode main.tex; then
    echo "❌ First xelatex pass failed. Check main.log for details."
    tail -n 50 main.log
    exit 1
fi

echo "📚 Running bibtex..."
if ! bibtex main 2>&1 | grep -v "Warning--empty"; then
    echo "⚠️  BibTeX completed with warnings (check main.blg)"
fi

echo "📖 Running xelatex (second pass)..."
if ! xelatex -interaction=nonstopmode main.tex > /dev/null; then
    echo "❌ Second xelatex pass failed. Check main.log for details."
    tail -n 50 main.log
    exit 1
fi

echo "📖 Running xelatex (third pass)..."
if ! xelatex -interaction=nonstopmode main.tex > /dev/null; then
    echo "❌ Third xelatex pass failed. Check main.log for details."
    tail -n 50 main.log
    exit 1
fi

echo "✅ Build complete!"
if [ -f main.pdf ]; then
    echo "📄 Opening main.pdf..."
    if command -v open &> /dev/null; then
        open main.pdf
    elif command -v xdg-open &> /dev/null; then
        xdg-open main.pdf
    else
        echo "PDF generated successfully at: $(pwd)/main.pdf"
    fi
else
    echo "❌ main.pdf was not generated!"
    exit 1
fi
