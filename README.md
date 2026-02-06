### 检查
```sh
[nvim]:checkhealth nvim-treesitter

brew install tree-sitter
brew install tree-sitter-cli
```


### github代理
```
git config --global http.https://github.com.proxy http://127.0.0.1:7890
git config --global https.https://github.com.proxy http://127.0.0.1:7890
```

### ClaudeCode
```
node -v
npm install -g @anthropic-ai/claude-code

ANTHROPIC_AUTH_TOKEN=
ANTHROPIC_BASE_URL=
```

### Copilot
```
brew unlink node
brew install node@20
brew link --force --overwrite node@20
node -v
node: v20.x.y
```
