# 佛山海猫 iSeacat Windows 一键时区切换器

一个轻量、透明、无第三方依赖的 Windows 时区切换工具。它可以在中国标准时间与美国太平洋时间之间一键切换。

## 特点

- 纯 PowerShell 和批处理脚本，无需安装第三方包
- 不联网，不采集或上传任何数据
- 不读取账号、Cookie、Token 或浏览器数据
- 只修改 Windows 系统时区，不控制其他应用程序
- 支持桌面快捷方式与快捷键

## 环境要求

- Windows 7 或更高版本
- Windows PowerShell 5.1 或 PowerShell 7
- 系统命令 `tzutil`

## 安装

1. 下载并解压本项目。
2. 双击 `install.bat`。
3. 桌面会生成“切中国”和“切美国”两个快捷方式。

默认快捷键：

- `Ctrl+Alt+C`：切换到 `China Standard Time`
- `Ctrl+Alt+U`：切换到 `Pacific Standard Time`

也可以双击 `run-tray.bat` 打开悬浮窗口。

## 修改美国时区

编辑 `tz_buttons.ps1` 顶部的 `usTz`：

```powershell
$config = @{
    chinaTz = "China Standard Time"
    usTz = "Pacific Standard Time"
}
```

常用美国时区：

- `Eastern Standard Time`：东部
- `Central Standard Time`：中部
- `Mountain Standard Time`：山区
- `Pacific Standard Time`：太平洋地区
- `Alaskan Standard Time`：阿拉斯加
- `Hawaiian Standard Time`：夏威夷

可运行 `tzutil /l` 查看 Windows 支持的完整时区列表。

## 权限说明

多数个人 Windows 电脑允许当前用户修改时区。如果系统策略禁止修改，请右键相应批处理文件并选择“以管理员身份运行”，或联系设备管理员。

## 卸载

删除桌面快捷方式和 `%LOCALAPPDATA%\iSeacatTimezoneSwitcher` 文件夹即可。

## 安全

所有逻辑都在可读的 `tz_buttons.ps1` 中。该版本只调用 Windows 自带的 `tzutil`，不会访问网络或控制其他应用程序。

## 许可证

[MIT License](LICENSE)
