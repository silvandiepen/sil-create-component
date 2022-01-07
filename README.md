# Create Component

A small bash script, to fast create a set of files for a component. I have been doing this repeatedly and got tired of it. Some things just come from lazyness.

### Usage

There are several ways you can use this. You can [https://create-component.sil.mt/assets/create-component.sh download](download) the script, or just create a shortcut in your `.bashrc` or `.zshrc` to use the script with a single command and always use the latests version.

### Install

Add the following to your `~/.bashrc` or `~/.zshrc` and now you can just use `sil:component` or whatever you want to call it.

```bash
function sil:component {
    bash <(curl -s https://create-component.sil.mt/assets/commit.sh)
}
```

### Similar projects

- (Commit)[https://commit.sil.mt]
