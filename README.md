# Dev container

running archlinux and neovim in a docker container.
Uses the current working directory.

## How to use

Build image:

```
docker build .
```

In your code workspace run:

```
path/to/rundev.sh containerNameOfYourChoice
```

Then:

```
docker exec -ti containerNameOfYourChoice zsh
```

To start nvim with a command: `vi +PlugInstall`
