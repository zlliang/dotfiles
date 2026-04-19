function agent-prepare -d "Prepare agent config files for the current project"
  if not test -f AGENTS.md; and not test -d .agents
    echo "Not an agent-assisted project"
    return 1
  end

  if test -f AGENTS.md; and not test -f CLAUDE.md
    echo "@AGENTS.md" >CLAUDE.md
    echo "Created CLAUDE.md"
  end

  if test -d .agents/skills; and not test -d .claude
    mkdir .claude
    ln -s ../.agents/skills .claude/skills
    echo "Created .claude/ with skills symlink"
  end
end
