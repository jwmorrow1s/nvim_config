# sumneko lua setup
* make sure ninja is installed
    ```console
    you@user:~$ git clone --depth=1 git clone --depth=1 git@github.com:sumneko/lua-language-server.git
    ```
    ```console
    you@user:~$ cd lua-language-server
    ```
    ```console
    you@user:~$ git submodule update --init --recursive
    ```
    ```console
    you@user:~$ cd 3rd/luamake
    ```
    ```console
    you@user:~$ compile/install.sh
    ```
    ```console
    you@user:~$ cd ../..
    ```
    ```console
    you@user:~$ ./3rd/luamake/luamake rebuild
    ```
* update .bashrc/.zshrc to have
    ```bash
      export PATH="$path_to_lua_language_server/bin/:$PATH"
    ```

## LSP
- You'll need to configure gopls (download gopls with go install, set up gopath, etc),
- You'll need to download typescript-language-server
- You'll need to download the elixir language server
- Lua Lsp config explained above

## Linting
- Supports linting of typescript/javascript, elixir, and golang. I didn't set up Lua linting/fixing

## Filesearch/Grep-ing
- I use telescope

## Debugger
### You'll need to run :VimspectorInstall to install the gadgets for your os
#### GOLANG
- for mac/linux(as $OS) put in "$HOME/.config/vimspector-config/confgurations/$OS/go/golang.json"
```json
{
  "$schema": "https://puremourning.github.io/vimspector/schema/vimspector.schema.json",
  "configurations": {
    "Run": {
      "adapter": "delve",
      "configuration": {
        "request": "launch",
        "program": "${fileDirname}",
        "mode": "debug",
        "dlvToolPath": "$HOME/.config/vimspector-config/gadgets/linux/delve/bin/dlv"
      }
    }
  }
}
  ```
