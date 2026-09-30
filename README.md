# Linux Security Compliance Automation

Linux 서버의 주요 보안 설정 및 운영 상태를 자동으로 점검하고, GitHub Actions를 통해 점검 결과를 자동으로 생성 및 관리하는 Linux Security Compliance Automation 프로젝트입니다.

기존의 수동 보안 점검 작업을 Bash Script로 자동화하고, Self-hosted Runner를 활용하여 실제 Linux 서버에서 보안 점검을 수행하도록 구성했습니다.

---

## 1. Project Overview

### Background

Linux 서버 운영 환경에서는 SSH 설정, 사용자 계정, 파일 권한, Firewall, SELinux, Audit Log 등 다양한 보안 항목을 지속적으로 점검해야 합니다.

본 프로젝트에서는 반복적으로 수행되는 Linux 보안 점검 작업을 자동화하고, GitHub Actions를 통해 자동으로 보안 상태를 확인할 수 있는 환경을 구축했습니다.

### Objectives

- Linux 서버 보안 점검 자동화
- Shell Script 기반 보안 상태 진단
- GitHub Actions 기반 자동화
- Self-hosted Runner 구성
- TXT / HTML 형식의 Report 생성
- GitHub Actions Artifact를 이용한 결과 관리

### Key Features

- 총 30개 Linux 보안 점검 항목
- PASS / FAIL 기반 점검 결과
- Security Compliance 계산
- HTML Report 자동 생성
- GitHub Actions 자동 실행
- Self-hosted Runner를 통한 실제 서버 점검
- 서버 설정을 변경하지 않는 진단 중심 구조

---

## 2. Architecture

    GitHub Repository
            |
            | git push
            v
       GitHub Actions
            |
            v
    Self-hosted Runner
         devops-lab
            |
            v
     security-check.sh
            |
            v
      30개 보안 점검
            |
       +----+----+
       |         |
       v         v
  TXT Report   generate-report.sh
                    |
                    v
             HTML Report
                    |
                    v
          GitHub Actions Artifact

### Workflow

    Developer
        |
        | git push
        v
    GitHub
        |
        v
    GitHub Actions
        |
        v
    Self-hosted Runner
        |
        v
    Security Check
        |
        +----> TXT Report
        |
        +----> HTML Report
        |
        v
    Artifact Upload

---

## 3. Environment

| Category | Environment |
|---|---|
| OS | Rocky Linux 8.10 |
| Server | devops-lab |
| Script | Bash |
| CI/CD | GitHub Actions |
| Runner | GitHub Actions Self-hosted Runner |
| Repository | GitHub |
| Report | TXT / HTML |

---

## 4. Tech Stack

Linux  
Rocky Linux  
Bash / Shell Script  
Git  
GitHub  
GitHub Actions  
Self-hosted Runner  
Linux Security  
Security Compliance  
HTML

---

## 5. Project Structure

    linux-security-compliance/
    │
    ├── README.md
    │
    ├── scripts/
    │   ├── security-check.sh
    │   └── generate-report.sh
    │
    ├── config/
    │
    ├── reports/
    │   └── security-report.txt
    │
    └── .github/
        └── workflows/
            └── security-check.yml

### Main Components

| File | Description |
|---|---|
| `security-check.sh` | Linux 보안 상태 점검 Script |
| `generate-report.sh` | TXT Report를 HTML Report로 변환 |
| `security-check.yml` | GitHub Actions Workflow |
| `security-report.txt` | 보안 점검 결과 |
| `security-report.html` | HTML 형식의 보안 점검 결과 |

---

## 6. Security Compliance Check

Linux 서버의 주요 보안 설정 및 운영 상태를 총 30개 항목으로 점검합니다.

| ID | Check |
|---|---|
| U-01 | Root 원격 로그인 제한 |
| U-02 | SSH 설정 확인 |
| U-03 | 패스워드 최대 사용 기간 |
| U-04 | Firewall 활성화 |
| U-05 | SSH 서비스 활성화 상태 |
| U-06 | 일반 사용자 계정 확인 |
| U-07 | 추가 UID 0 계정 존재 여부 |
| U-08 | `/etc/passwd` 파일 권한 |
| U-09 | `/etc/shadow` 파일 권한 |
| U-10 | SSH 서비스 실행 상태 |
| U-11 | SSH 기본 포트 사용 여부 |
| U-12 | SSH PasswordAuthentication 비활성화 |
| U-13 | SSH 빈 패스워드 로그인 제한 |
| U-14 | SSH X11Forwarding 비활성화 |
| U-15 | Firewall 활성화 상태 |
| U-16 | SELinux 활성화 상태 |
| U-17 | auditd 서비스 실행 상태 |
| U-18 | rsyslog 서비스 실행 상태 |
| U-19 | 시간 동기화 서비스 상태 |
| U-20 | 실행 중 서비스 확인 |
| U-21 | `/etc/passwd` 소유자 및 권한 |
| U-22 | `/etc/shadow` 소유자 및 권한 |
| U-23 | `/etc/group` 소유자 및 권한 |
| U-24 | SSH 설정 파일 권한 |
| U-25 | `/etc/hosts` 파일 권한 |
| U-26 | Audit 로그 존재 여부 |
| U-27 | SSH 로그인 실패 로그 확인 |
| U-28 | 최근 로그인 기록 확인 |
| U-29 | Root 파일시스템 사용량 |
| U-30 | 주요 보안 서비스 실행 상태 |

### Security Check Script

    chmod +x scripts/security-check.sh
    ./scripts/security-check.sh
    
<img width="469" height="621" alt="image" src="https://github.com/user-attachments/assets/23fe761e-6abc-4771-a20f-a7af87d7087e" />


### Test Result

| Item | Result |
|---|---:|
| Total Checks | 30 |
| PASS | 21 |
| FAIL | 9 |
| Compliance | 70% |

본 프로젝트는 진단 목적의 프로젝트입니다.

FAIL 항목이 발견되더라도 Script가 서버의 설정을 자동으로 변경하지 않습니다.

SSH, Firewall, SELinux, Password Policy, 파일 권한 등의 설정은 자동으로 변경하지 않고 현재 서버의 상태만 진단하도록 구성했습니다.

---

## 7. GitHub Actions

GitHub Actions를 이용하여 보안 점검 프로세스를 자동화했습니다.

### Workflow

    Git Push
       ↓
    Checkout Repository
       ↓
    Security Compliance Check
       ↓
    Generate HTML Report
       ↓
    Display Report
       ↓
    Upload Artifact

### Workflow Configuration

    name: Linux Security Compliance

    on:
      push:
        branches:
          - main
      workflow_dispatch:

    jobs:
      security-check:
        runs-on: self-hosted

        steps:
          - name: Checkout repository
            uses: actions/checkout@v4

          - name: Run security compliance check
            run: |
              chmod +x scripts/security-check.sh
              ./scripts/security-check.sh

          - name: Generate HTML report
            run: |
              chmod +x scripts/generate-report.sh
              ./scripts/generate-report.sh

          - name: Display security report
            run: |
              cat reports/security-report.txt

          - name: Upload security reports
            uses: actions/upload-artifact@v4
            with:
              name: security-compliance-report
              path: |
                reports/security-report.txt
                reports/security-report.html

---

## 8. Self-hosted Runner

GitHub Actions의 실행 환경으로 직접 관리하는 Linux 서버를 Self-hosted Runner로 구성했습니다.

    GitHub
       |
       v
    GitHub Actions
       |
       v
    Self-hosted Runner
       |
       v
    devops-lab

### Runner Configuration

    Runner Name : devops-lab
    OS          : Linux
    Architecture: x64

Runner 실행:

    ./run.sh

GitHub Repository에서 다음 메뉴를 통해 Runner 상태를 확인할 수 있습니다.

    Settings
      ↓
    Actions
      ↓
    Runners

---

## 9. Security Report

보안 점검 결과는 TXT 형식으로 생성되며, 별도의 Script를 통해 HTML Report로 변환됩니다.

### TXT Report

    reports/security-report.txt

### HTML Report

    reports/security-report.html

### HTML Report Generation

    chmod +x scripts/generate-report.sh
    ./scripts/generate-report.sh

### Report Result

    Total Checks : 30
    PASS         : 21
    FAIL         : 9
    Compliance   : 70%

HTML Report는 GitHub Actions 실행 후 Artifact로 업로드됩니다.

    security-compliance-report
    ├── security-report.txt
    └── security-report.html

---

## 10. Execution Result

GitHub Actions 실행을 통해 Linux 서버의 보안 상태를 자동으로 점검했습니다.

### Result

    ========================================
    PASS : 21
    FAIL : 9
    ========================================

### Compliance

    70%

실제 서버의 현재 설정을 기준으로 결과를 생성하기 때문에 FAIL 항목 역시 실제 환경의 상태를 반영합니다.

본 프로젝트에서는 점검 결과를 기반으로 서버 설정을 자동 수정하지 않고, 진단 결과를 제공하는 단계까지 구현했습니다.

---

## 11. Troubleshooting

### 11.1 Report Permission Issue

초기 Report 경로를 절대경로로 지정했습니다.

    /root/project-05-security/reports/security-report.txt

하지만 GitHub Actions Self-hosted Runner는 `actions` 사용자로 실행되기 때문에 해당 경로에 Report를 생성하는 과정에서 Permission 문제가 발생했습니다.

### Solution

Script 위치를 기준으로 상대경로를 사용하도록 변경했습니다.

    REPORT="$(dirname "$0")/../reports/security-report.txt"

이를 통해 Repository 내부의 `reports` 디렉터리에 Report가 생성되도록 수정했습니다.

---

### 11.2 GitHub Actions YAML Syntax Error

초기 Workflow 작성 과정에서 YAML indentation 문제로 다음과 같은 오류가 발생했습니다.

    Invalid workflow file
    You have an error in your yaml syntax

Workflow indentation 및 Artifact `path` 설정을 수정하여 해결했습니다.

최종적으로 TXT와 HTML Report를 모두 Artifact로 업로드하도록 구성했습니다.

---

## 12. What I Learned

### Linux Security

SSH, 사용자 계정, 파일 권한, Firewall, SELinux, Audit 및 Logging 등 Linux 서버의 주요 보안 설정을 자동으로 점검하는 방법을 경험했습니다.

### Shell Script Automation

Linux 시스템 정보를 수집하고 조건에 따라 PASS / FAIL을 판단하는 Bash Script를 구현했습니다.

### GitHub Actions

Git Push를 기준으로 보안 점검을 자동 실행하고 결과를 Artifact로 저장하는 CI 자동화 환경을 구축했습니다.

### Self-hosted Runner

GitHub에서 제공하는 호스팅 Runner가 아닌 직접 관리하는 Linux 서버를 GitHub Actions 실행 환경으로 구성했습니다.

### Security Automation

반복적인 Linux 보안 점검 업무를 자동화하여 점검 과정과 결과를 표준화하는 경험을 쌓았습니다.

---

## 13. Future Improvements

- 보안 점검 항목 추가
- JSON 형식 Report 추가
- 여러 Linux 서버에 대한 중앙화된 점검
- Prometheus / Grafana 기반 Compliance Dashboard
- Ansible을 이용한 별도의 보안 설정 자동화
- 서버별 Compliance 이력 관리

---
