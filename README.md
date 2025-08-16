# Linux-Backup-Automation
Bash + cron solution for detecting and backing up updated password files

## 🔎 Project Overview

This project simulates a real-world Linux systems engineering task at a top-tech company (ABC International Inc.).

As the Lead Linux Developer, the task is to design a script called backup.sh that:

Runs daily (via cron job).

Automatically detects encrypted password files modified within the last 24 hours.

Creates secure backups of these updated files to a designated backup directory.

This project demonstrates Linux system administration, shell scripting, automation, and security-conscious development practices.

## 🎯 Objectives

Automate daily backups using Bash scripting and cron jobs.

Work with Linux utilities (find, tar, cp, date, etc.).

Ensure only files updated in the past 24 hours are included in backups.

Demonstrate secure handling of sensitive files.

## 🛠️ Tech Stack / Tools

Linux (Ubuntu/CentOS/Debian)

Bash Shell

cron (for scheduling)

find, cp, tar, gzip (for file management & compression)

## 📂 Repository Structure
.
├── backup.sh          # Main backup script
├── /backups           # Backup output directory (auto-created if missing)
├── sample_data/       # Example encrypted password files (for demo/testing)
└── README.md          # Documentation

## 🚀 How to Run
1️⃣ Clone Repository
git clone https://github.com/<your-username>/linux-backup-script.git
cd linux-backup-script

2️⃣ Make Script Executable
chmod +x backup.sh

3️⃣ Run Script Manually
./backup.sh

4️⃣ Automate with Cron (Daily @ Midnight)
crontab -e


Add the line:

0 0 * * * /path/to/backup.sh

## 📝 Example Script Workflow

Script checks /etc/security/ (or any given directory) for encrypted password files.

Identifies those modified in the last 24 hours.

Copies them into /backups/YYYY-MM-DD/ folder.

Logs backup details into backup.log.

## 📊 Sample Output
[2025-08-16 00:00:01] Backup started
Files backed up: /etc/security/shadow.enc
Backup saved to: /backups/2025-08-16/shadow.enc.gz
[2025-08-16 00:00:02] Backup completed successfully

## 🔑 Skills Demonstrated

Linux System Administration

Bash Scripting

File System Management

Task Automation with Cron

Secure Backup Strategies

## 🧑‍💻 Author

Onyinyechukwu Kenneth Nebe

💼 Data Engineer
