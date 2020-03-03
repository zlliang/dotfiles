# Create a LaTeX document

function create-latex -d "Create a LaTeX document"
  if not test (echo $argv)
    set argv document
  end
  cp ~/Documents/projects/latex-templates/doc-preamble.tex .
  cp ~/Documents/projects/latex-templates/document.tex $argv.tex
  cp ~/Documents/projects/latex-templates/*.bib .
end
