# ✨ 星空祝福 / 翻页信笺

一个单文件静态网页：**桌面端是星空粒子告白动画，手机端是翻页祝福信笺**，两端共用同一个 `index.html`，自动识别设备切换排版。

## 在线预览

- **GitHub Pages**: 部署后访问 `https://<你的用户名>.github.io/<仓库名>/`
- 手机打开: 翻页信笺（祝福语版）
- 电脑打开: 星空粒子聚字动画（含「想 / 不想」小互动）

## 本地运行

```bash
# 方式一：任意静态服务器
npx http-server -p 8888

# 方式二：Windows 双击「启动星空.bat」
# （自动启动本地服务并打开浏览器，含 frp 公网分享提示）
```

## 技术说明

- 纯前端单文件，无构建步骤；`three.min.js` 本地优先，失败才走 CDN
- 桌面端：Three.js 粒子系统（星海 → 聚字 → 聚成按钮 → 问答），8000 粒子
- 手机端：CSS 3D 翻页信笺，不加载 Three.js，秒开轻量
- 适配逻辑：`"ontouchstart" in window || navigator.maxTouchPoints > 0` 判定触摸设备

## 自定义

打开 `index.html` 顶部配置区：

```js
const TEXT = "祝你天天开心";      // 桌面端粒子聚成的文字（支持 \n 换行）
const ANSWER_TEXT = "就不告诉你";  // 桌面端点击「想」后的答案
```

手机端信笺祝福语在 HTML 中的 `#letter` 区块修改。

## 文件结构

```
index.html        # 唯一页面（桌面星空 + 手机信笺）
three.min.js      # 本地 Three.js（桌面端用，手机端不加载）
shot.jpg          # 效果截图
server/           # Go 静态服务器（打包 exe 用，本地运行不需要）
启动星空.bat      # Windows 一键启动脚本
```
