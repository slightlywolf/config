# ~/.gitconfig
[merge]
  tool = diffview
[mergetool]
  prompt = false
  keepBackup = false
[mergetool "diffview"]
  cmd = nvim -n -c "DiffviewOpen" "$MERGE"
