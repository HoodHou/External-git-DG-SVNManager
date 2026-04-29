# 梦境 SVN 管理器

这是一个给游戏策划使用的 SVN 简化工具，目标是把常用操作做成少量中文按钮，降低误操作。

## 软件更新

- 软件启动时会检查 GitHub 最新 Release。
- 如果发现新版本，状态栏会显示“工具有新版本”。
- 点击状态栏提示，或点击“更多操作 -> 检查工具更新”，会打开更新面板。
- 更新面板会显示当前版本、GitHub 最新版本、更新说明和下载文件。
- 点击“下载并更新”后，软件会下载 Release zip，关闭当前程序，覆盖当前目录，然后自动重启。
- 开发环境下如果运行目录能找到 `.git`，仍支持通过 `git pull` 更新源码。

发布新版本时需要：

1. 修改 `SVNManager/SVNManager.csproj` 里的 `Version` / `AssemblyVersion` / `FileVersion` / `InformationalVersion`。
2. 用 Release 配置生成新的 Windows x64 zip。
3. 在 GitHub 创建新的 Release，例如 `v0.1.1`。
4. 把 zip 作为 Release 附件上传，文件名建议包含 `win-x64`，例如 `DreamSVNManager-win-x64-v0.1.1.zip`。

用户不需要每 10 分钟检查。软件只在启动时自动检查一次；之后用户可以手动点“检查工具更新”。

## 外部工具

- 发布包不再内置分久必合，避免每次更新都下载很大的 `ExternalTools`。
- 每台电脑第一次使用外部表格对比/合并前，需要在“更多操作 -> 设置”里选择本机的 `分久必合.exe`。
- 路径会保存到 `%AppData%\SVNManager\settings.json`，之后不用重复配置。
- 如果不配置分久必合，内置文本差异和 Excel 差异预览仍然可用，只是不能调用外部合并工具。

## 打开没反应时

如果双击 `SVNManager.exe` 没有任何反应，请让对方双击 `启动-带诊断.cmd`。

诊断脚本会：

1. 检查是否完整解压。
2. 启动 `SVNManager.exe`。
3. 如果程序立刻退出，显示 `%AppData%\SVNManager\startup.log` 里的错误。

把诊断窗口截图或 `startup.log` 发回来，就能定位是系统版本、文件缺失、权限拦截还是程序异常。
