# Git Repository Setup Guide

## ✅ Local Repository Status

Your local Git repository has been successfully initialized and configured.

- **Repository Location**: `H:\FSC_Portal\Offline-Portal`
- **Current Branch**: `master`
- **Initial Commit**: `d0c7b32` - FSC Portal Offline Application
- **Files Tracked**: 170 files (51,344+ lines of code)
- **Working Tree**: Clean

## 📋 What's Been Done

1. ✅ Initialized Git repository (`git init`)
2. ✅ Enhanced `.gitignore` with project-specific exclusions
3. ✅ Staged all project files
4. ✅ Created initial commit with comprehensive description

## 🚀 Next Steps: Remote Repository Setup

### Option A: GitHub (Recommended)

1. **Create a new repository on GitHub**:
   - Go to https://github.com/new
   - Repository name: `FSC-Portal-Offline` (or your preferred name)
   - Description: "Flutter-based offline field service portal for Windows"
   - Choose visibility (Private recommended for internal projects)
   - **DO NOT** initialize with README, .gitignore, or license (we already have these)

2. **Link and push to GitHub**:
   ```powershell
   git remote add origin https://github.com/YOUR_USERNAME/FSC-Portal-Offline.git
   git branch -M main
   git push -u origin main
   ```

3. **Optional: Set up SSH instead of HTTPS**:
   ```powershell
   git remote set-url origin git@github.com:YOUR_USERNAME/FSC-Portal-Offline.git
   ```

### Option B: GitLab

1. **Create a new project on GitLab**:
   - Go to https://gitlab.com/projects/new
   - Project name: `FSC-Portal-Offline`
   - Visibility level: Choose appropriate level
   - **Uncheck** "Initialize repository with a README"

2. **Link and push to GitLab**:
   ```powershell
   git remote add origin https://gitlab.com/YOUR_USERNAME/fsc-portal-offline.git
   git branch -M main
   git push -u origin main
   ```

### Option C: Azure DevOps

1. **Create a new repository in Azure DevOps**:
   - Navigate to your project
   - Repos → Files → Initialize with Git
   - Copy the remote URL

2. **Link and push**:
   ```powershell
   git remote add origin https://dev.azure.com/YOUR_ORG/YOUR_PROJECT/_git/FSC-Portal-Offline
   git branch -M main
   git push -u origin main
   ```

### Option D: Self-Hosted / Other Git Server

```powershell
git remote add origin YOUR_GIT_SERVER_URL
git branch -M main
git push -u origin main
```

## 🔧 Useful Git Commands

### Check Status
```powershell
git status                    # View current status
git log --oneline -10         # View last 10 commits
git branch -a                 # List all branches
```

### Daily Workflow
```powershell
git add .                     # Stage all changes
git commit -m "Your message"  # Commit changes
git push                      # Push to remote
git pull                      # Pull latest changes
```

### Branch Management
```powershell
git branch feature-name       # Create new branch
git checkout feature-name     # Switch to branch
git checkout -b feature-name  # Create and switch
git merge feature-name        # Merge branch into current
```

### View Changes
```powershell
git diff                      # View unstaged changes
git diff --staged             # View staged changes
git diff HEAD~1               # Compare with last commit
```

## 📊 Repository Structure

```
FSC_Portal/Offline-Portal/
├── .git/                     # Git repository data
├── .gitignore               # Ignored files configuration
├── lib/                     # Flutter application code
├── android/                 # Android platform files
├── windows/                 # Windows platform files
├── assets/                  # Application assets
├── execution/               # Python automation scripts
├── directives/              # Task directives
├── test/                    # Test files
└── [Documentation Files]    # Comprehensive project docs
```

## 🛡️ Protected Files (.gitignore)

The following are automatically excluded from version control:

- Build artifacts (`/build/`, `/coverage/`)
- Platform-specific (`/android/app/debug`, `/android/app/release`)
- Dependencies (`.dart_tool/`, `.pub-cache/`)
- Temporary files (`.tmp/`, `inventory_temp/`, `xlsx_temp/`)
- Python artifacts (`__pycache__/`, `*.pyc`)
- OS-specific (`Thumbs.db`, `.DS_Store`)

## 📝 Commit Message Convention

Follow this format for clear commit history:

```
Type: Brief description (50 chars or less)

- Detailed point 1
- Detailed point 2
- Detailed point 3

[Optional: Breaking changes, issue references]
```

**Types**: `feat`, `fix`, `docs`, `refactor`, `test`, `chore`, `perf`, `style`

## 🔐 Security Notes

- **Never commit**: API keys, passwords, secrets, credentials
- **Sensitive files**: Add to `.gitignore` immediately
- **Review before commit**: Always check `git status` and `git diff`
- **Use `.env` files**: For environment-specific configuration (and add to `.gitignore`)

## 🤝 Collaboration Workflow

For team collaboration, consider:

1. **Feature branches**: Create separate branches for each feature
2. **Pull requests**: Review code before merging to main
3. **Protect main branch**: Require reviews and passing tests
4. **Semantic versioning**: Tag releases (v1.0.0, v1.1.0, etc.)

---

**VyreVault Studios** - FSC Portal Offline Project
