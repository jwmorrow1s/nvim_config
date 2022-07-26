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
