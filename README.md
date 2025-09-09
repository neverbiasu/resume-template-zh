# LaTeX 简历模板（XeLaTeX）

简洁、易用的中文简历模板，默认展示顺序：教育 > 工作 > 科研/项目。适合科研和求职场景，支持头像、可点击链接与快速自定义。

## 亮点
- A4、11pt、简约排版
- 优先展示：教育 > 工作 > 科研/项目
- 支持头像：`\photo[宽度]{路径}`
- 可点击链接（`hyperref` 已启用）

## 文件结构（项目根目录）
```
resume-template/
├─ resume.cls         # 样式类（主配置）
├─ main.tex           # 示例与编译入口
├─ content/           # 用户可编辑的模块（basic、education、work 等）
├─ assets/            # 图片等静态文件（avatar 放这里）
├─ build.cmd          # Windows 快速构建脚本
├─ README.md
└─ .gitignore
```

## 快速开始（Windows - cmd）
Checklist:
- 安装 TeX 发行版（TeX Live 或 MiKTeX）
- 可用 `xelatex` 命令或直接运行 `build.cmd`

1. 使用 `build.cmd`（推荐，自动检测 xelatex 并运行两次）

```cmd
build.cmd
```

2. 或手动运行 XeLaTeX（两遍）

```cmd
xelatex -interaction=nonstopmode -halt-on-error main.tex
xelatex -interaction=nonstopmode -halt-on-error main.tex
```

> 说明：两遍编译可以保证引用、目录和交叉引用正确。

## 修改个人信息与内容
- 编辑 `content/basic.tex` 来设置姓名、联系方式、个人主页与头像路径。
- 按模块编辑 `content/education.tex`、`content/work.tex`、`content/research.tex` 等。
- 模板采用 `\providecommand`（类）+`\renewcommand`（内容）模式，编辑 `content` 下文件不会改动类定义。

如果你想在顶端显示“基本信息表格”，在 `content/basic.tex` 中添加一行：

```tex
\ShowBasicInfotrue
```

## 头像
- 将头像放入 `assets/`，例如 `assets/avatar.jpg`，并在 `main.tex` 取消注释：

```tex
% \photo[2.6cm]{assets/avatar.jpg}
```

可调节宽度参数以适配版式。

## 字体与兼容性
- 模板默认使用：英文字体 `Times New Roman`、中文 `SimSun`。如系统缺失，请在 `resume.cls` 中替换为本机已安装的字体（例如 `Microsoft YaHei`）。
- 若出现 SimSun 粗体缺失的警告，可以在 `resume.cls` 为 CJK 指定 `BoldFont`：

```tex
\setCJKmainfont{SimSun}[BoldFont=SimHei]
```

或直接改用支持粗体的字族：

```tex
\setCJKmainfont{Microsoft YaHei}
```

## 常见问题（快速排查）
- `xelatex not found`：确认 MiKTeX/TeX Live 已安装且 `xelatex` 在 PATH 中；或在 MiKTeX Console 中安装 `xetex`。
- 若看到 plain TeX 提示（例如 `I can't find file 'Live'`），说明误启动了非 xelatex 进程，关闭提示并按上述步骤确认 `xelatex` 可用。
- 字体问题：在 `resume.cls` 替换 `\setmainfont`/`\setCJKmainfont` 为本机字体。

## 自定义示例
- 增加区块：直接在 `main.tex` 或任意 `content/*.tex` 使用 `\section*{区块名}`。
- 条目模板：

```tex
\entry{标题}{单位}{地点}{起止时间}{
  \item 要点 1
  \item 要点 2
}
```

## 构建输出
- 运行 `build.cmd` 会在工作目录生成 `main.pdf`（通常 1–2 页，取决于内容）。

## 许可证
MIT — 可以自由使用和修改。

---
若需我帮你：一页压缩版、双语版本、不同配色或改字体，我可以在当前模板上快速实现并验证。 
