# Sil Create Component

A small bash script, to fast create a set of files for a component. I have been doing this repeatedly and got tired of it. Some things just come from lazyness.

### Install

Add the following to your `~/.bashrc` or `~/.zshrc` and now you can just use `sil:component` or whatever you want to call it.

```bash
function sil:component {
    bash < <(curl -s https://create-component.sil.mt/assets/commit.sh)
}
```
