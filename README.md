# Web / WordPress

- 前台：https://silveryj-atzj.me
- 后台：https://silveryj-atzj.me/wp-admin/

## 这个仓库放什么

WordPress 核心（`wp-*.php`、`wp-admin/`、`wp-includes/`）**不放进仓库**（由官方更新，放进来只会冲突）。
这里只放你**自己写/改**的东西：

```
Web/WordPress/
├─ wp-content/
│  ├─ themes/     ← 你自己的主题 / 子主题（推荐子主题，别改官方主题）
│  └─ plugins/    ← 自己写的插件
├─ deploy.ps1     ← 把 wp-content 同步到 CT600
└─ README.md
```

## 工作流

1. 在本地 `wp-content/themes/my-theme/` 写主题文件
2. `powershell -File deploy.ps1` → 同步到 CT600 `/opt/lemp/html/wp-content/`
3. 后台 → 外观 → 主题 → 启用
4. `git add -A && git commit -m "..." && git push`

> 不想写主题只想改样式？后台「外观 → 自定义」就够了，不必进这个仓库。
