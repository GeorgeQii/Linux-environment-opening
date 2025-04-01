要使用搭建在 GitHub 上的 `Linux-environment-opening` 仓库中的 `sh` 脚本，你可以按照以下步骤操作：

### 步骤 1：克隆仓库

首先，你需要将仓库克隆到你的本地机器上。打开终端，然后运行以下命令：

```bash
git clone https://github.com/GeorgeQii/Linux-environment-opening.git
```

这将会把仓库克隆到当前目录下的 `Linux-environment-opening` 文件夹中。

### 步骤 2：进入仓库目录

使用 `cd` 命令进入克隆下来的仓库目录：

```bash
cd Linux-environment-opening
```

### 步骤 3：查看脚本

在仓库目录中，你可以使用 `cat` 命令或者文本编辑器来查看 `menu.sh` 脚本的内容：

```bash
cat menu.sh
```

或者使用你喜欢的文本编辑器打开它，例如 `nano` 或 `vim`：

```bash
nano menu.sh
```

### 步骤 4：赋予执行权限

在运行脚本之前，你需要给它执行权限。使用 `chmod` 命令来实现：

```bash
chmod +x menu.sh
```

### 步骤 5：运行脚本

现在，你可以运行脚本了。在终端中执行以下命令：

```bash
./menu.sh
```

### 步骤 6：按照菜单操作

脚本运行后，会显示一个菜单，你可以按照菜单提示输入相应的数字来选择要执行的操作。

### 注意事项：

- 确保你的系统上已经安装了 `git`。
- 确保你有足够的权限来执行脚本中的命令，某些操作可能需要 `sudo` 权限。
- 如果脚本中的操作涉及到网络连接，请确保你的网络连接正常。
- 在执行任何系统级别的更改之前，请确保你了解这些操作的后果。

按照这些步骤，你应该能够成功地使用 GitHub 上的 `Linux-environment-opening` 仓库中的 `sh` 脚本。
