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
claude install
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bash_profile && source ~/.bash_profile

ANTHROPIC_AUTH_TOKEN=
ANTHROPIC_BASE_URL=
```
