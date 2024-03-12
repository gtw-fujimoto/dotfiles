# dotfiles

## setup modules

```
curl -sL https://raw.githubusercontent.com/gtw-fujimoto/dotfiles/master/setup.sh | sh
```

ref: https://orgachem.hatenablog.com/entry/2014/05/13/001100

## setup git repos

- new terminal and ghq

```
ssh -T git@github.com; sh $HOME/.dotfiles/ghq.sh
```

gh auth login --with-token < mytoken

に切り替える予定

## develop .dotfiles

```
cd $HOME/.dotfiles
git remote -v
git remote set-url origin git@github.com:gtw-fujimoto/dotfiles.git

git commit
```