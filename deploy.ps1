# 同步本地 wp-content 到 CT600 的 WordPress
$ErrorActionPreference = 'Stop'
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$content = Join-Path $here 'wp-content'
if (-not (Test-Path $content)) { throw 'wp-content 目录不存在' }

$tgz = Join-Path $env:TEMP 'wp-content.tgz'
if (Test-Path $tgz) { Remove-Item $tgz -Force }
& tar -czf $tgz -C $content .
& scp -o BatchMode=yes $tgz pve:/tmp/wp-content.tgz

$remote = @'
set -e
pct push 600 /tmp/wp-content.tgz /tmp/wp-content.tgz
pct exec 600 -- bash -lc 'mkdir -p /opt/lemp/html/wp-content && tar -xzf /tmp/wp-content.tgz -C /opt/lemp/html/wp-content && rm -f /tmp/wp-content.tgz && echo synced'
'@
$remote | & ssh -o BatchMode=yes -o ConnectTimeout=15 pve 'bash -s'
Write-Host 'wordpress wp-content synced' -ForegroundColor Green
