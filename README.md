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

## 自动部署

push 到 GitHub 后，自托管 Runner 会打包 `wp-content` 并推给内网部署入口，服务器覆盖同步 `themes/` 与 `plugins/`（不删除线上已有文件，避免误删）。

---

# Web / WordPress (English)

- Site: https://silveryj-atzj.me
- Admin: https://silveryj-atzj.me/wp-admin/

## What goes in this repository

WordPress core (`wp-*.php`, `wp-admin/`, `wp-includes/`) is **not** committed — it is updated upstream and would only cause conflicts.
Only your own work lives here:

```
Web/WordPress/
├─ wp-content/
│  ├─ themes/     ← your themes / child themes (prefer child themes over editing a bundled one)
│  └─ plugins/    ← your own plugins
├─ deploy.ps1     ← sync wp-content to the server
└─ README.md
```

## Workflow

1. Develop under `wp-content/themes/my-theme/`
2. `powershell -File deploy.ps1` → syncs to `/opt/lemp/html/wp-content/` on the web container
3. Admin → Appearance → Themes → activate
4. `git add -A && git commit -m "..." && git push`

> Only need style tweaks? Use Appearance → Customize in the admin; you do not need this repository.

## Automated deployment

After pushing to GitHub, a self-hosted runner packages `wp-content` and posts it to the internal deploy endpoint. The server overlays `themes/` and `plugins/` (it never deletes existing files on the server, to avoid accidental removal).
