# Neovim Git 工作流指南 (Gitsigns & Snacks)

本文档旨在帮助你掌握 Neovim 中强大的 Git 集成功能。通过 `gitsigns.nvim`（行级操作）和 `snacks.nvim`（项目级操作）的配合，你可以完全脱离命令行进行日常开发。

## 1. 核心概念：Hunk (代码块)
Git 并不只是管理文件，它管理的是内容的变更。Gitsigns 关注的核心单位是 **Hunk**——即一段连续的新增、修改或删除的代码。

- **视觉提示 (左侧边栏)**:
  - `▎` (蓝/绿): 新增的代码。
  - `▎` (黄): 修改过的代码。
  - `` (红): 被删除的代码位置。

## 2. 常用操作速查表

### 导航与查看
| 快捷键 | 功能 | 场景 |
| :--- | :--- | :--- |
| `]c` | **下一处修改** | 快速跳转到下一个 Hunk，Code Review 时神器。 |
| `[c` | **上一处修改** | 回到上一个修改点。 |
| `<leader>gp` | **预览修改** (Preview) | 忘记改了啥？弹窗显示修改前的代码对比。 |
| `<leader>gb` | **行 Blame** (Blame) | 显示当前行详细的提交信息（作者、时间、Message）。 |
| `<leader>gd` | **Diff 对比** (Diff) | 开启左右分屏 Diff 模式，对比暂存区。 |
| `<leader>gl` | **Git 历史** (Log) | 查看当前文件或选区的提交历史 (Smart History)。 |

### 编辑与操作
| 快捷键 | 功能 | 场景 |
| :--- | :--- | :--- |
| `<leader>gS` | **暂存 Hunk** (Stage) | **注意是大写 S**。只提交当前这几行修改，不提交整个文件。 |
| `<leader>gr` | **重置 Hunk** (Reset) | 后悔药。撤销当前这几行的修改，恢复到上一次提交的状态。 |
| `<leader>gu` | **撤销暂存** (Undo) | 刚才 `<leader>gS` 暂存错了？按这个撤回暂存状态。 |
| `<leader>gR` | **重置 Buffer** | **危险**！丢弃当前文件所有的修改。 |

### 项目级操作 (Snacks)
| 快捷键 | 功能 | 场景 |
| :--- | :--- | :--- |
| `<leader>gs` | **Git Status** | 查看哪些文件变动了。在弹出的窗口中，你可以按 `TAB` 勾选文件进行暂存。 |

## 3. 典型工作流场景

### 场景 A：精准提交 (Atomic Commit)
你同时修了 Bug A 和 Bug B，它们在同一个文件里。
1. 移动光标到 Bug A 的修复代码处。
2. 按 `<leader>gS` (Stage)。现在只有 Bug A 的修复被暂存了。
3. 移动到 Bug B 的修复处，**不操作**。
4. 运行 `:Gcommit -m "fix: bug A"` (或者使用你的 Git 终端工具)。
5. 结果：Bug A 被提交，Bug B 仍留在工作区等待下一次提交。

### 场景 B：快速试错
你正在尝试重构一个函数，改得面目全非后发现思路错了。
1. 看着满屏的黄色修改条。
2. 按 `<leader>gr` (Reset)。
3. 瞬间恢复原样，就像什么都没发生过。

### 场景 C：追溯历史
看到一行奇怪的代码 `if (x == null) return;`。
1. 停留在该行，行尾淡淡显示: `zhangsan, 2 years ago - fix NPE in production`。
2. 还没看懂？按 `<leader>gb` 查看完整的 Commit 详情。
3. 想看这个文件的演变？按 `<leader>gl` 浏览历史记录。

## 4. 常见问题
- **Q: 为什么 `<leader>gs` 不能暂存 Hunk?**
  - A: 为了避免冲突，`<leader>gs` 保留给了查看文件级状态 (Git Status)。暂存 Hunk 请使用 **`<leader>gS`** (Shift + s)。
- **Q: 为什么按 `<leader>h` 没反应了？**
  - A: 我们已经将 Gitsigns 的所有操作移到了 `<leader>g` 下，把 `<leader>h` 归还给了你习惯的水平分屏操作。
