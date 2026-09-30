# Linux Security Compliance Automation

Linux 서버의 주요 보안 설정 및 운영 상태를 자동으로 점검하고, GitHub Actions를 통해 점검 결과를 자동으로 생성 및 보관하는 Linux Security Compliance Automation 프로젝트입니다.

본 프로젝트는 서버의 보안 설정을 직접 변경하지 않고, 현재 상태를 진단하여 PASS / FAIL 형태로 결과를 제공하는 것을 목적으로 합니다.

---

## 1. 프로젝트 개요

Linux 서버 운영 환경에서는 SSH, 사용자 계정, 파일 권한, Firewall, SELinux, 로그 서비스 등 다양한 보안 설정을 지속적으로 점검해야 합니다.

본 프로젝트에서는 이러한 반복적인 보안 점검 작업을 Bash Script로 자동화하고, GitHub Actions와 Self-hosted Runner를 이용하여 자동 실행 환경을 구성했습니다.

### 주요 기능

- Linux 서버 보안 상태 자동 점검
- 총 30개 보안 점검 항목
- PASS / FAIL 결과 출력
- TXT 형식의 보안 점검 리포트 생성
- HTML 형식의 보안 점검 리포트 생성
- GitHub Actions를 이용한 자동 실행
- Self-hosted Runner를 이용한 Linux 서버 실행
- GitHub Actions Artifact를 이용한 결과 보관

---

## 2. 프로젝트 목표

### 2.1 Linux 보안 점검 자동화

수동으로 수행하던 Linux 서버 보안 점검을 Shell Script로 자동화합니다.

### 2.2 점검 결과 표준화

각 보안 항목의 결과를 PASS / FAIL 형태로 표준화하여 서버의 보안 상태를 빠르게 확인할 수 있도록 구성합니다.

### 2.3 CI/CD 기반 자동화

GitHub에 변경사항이 Push되면 GitHub Actions가 자동으로 보안 점검 Script를 실행하도록 구성합니다.

### 2.4 Report 자동 생성

보안 점검 결과를 TXT와 HTML 형식으로 생성하여 사람이 쉽게 확인하고 결과를 보관할 수 있도록 구성합니다.

---

## 3. 시스템 환경

| 구분 | 환경 |
|---|---|
| OS | Rocky Linux 8.10 |
| Server | devops-lab |
| Script | Bash |
| Repository | GitHub |
| CI/CD | GitHub Actions |
| Runner | Self-hosted Runner |
| Report | TXT / HTML |

---

## 4. 시스템 구성

~~~text
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
                    +-----------+-----------+
                    |                       |
                    v                       v
          security-report.txt      generate-report.sh
                                            |
                                            v
                                  security-report.html
                                            |
                                            v
                                GitHub Actions Artifact
~~~

---

## 5. 프로젝트 구조

~~~text
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
~~~

### 파일 설명

| 파일 | 설명 |
|---|---|
| `scripts/security-check.sh` | Linux 보안 상태를 점검하는 메인 Script |
| `scripts/generate-report.sh` | TXT 결과를 HTML Report로 변환 |
| `.github/workflows/security-check.yml` | GitHub Actions Workflow |
| `reports/security-report.txt` | 보안 점검 결과 |
| `reports/security-report.html` | HTML 형식의 점검 결과 |

---

## 6. 보안 점검 항목

총 30개의 Linux 보안 및 운영 상태를 점검합니다.

| ID | 점검 항목 |
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

---

## 7. Security Check

메인 점검 Script는 Linux 서버의 보안 설정 및 운영 상태를 확인합니다.

실행:

~~~bash
chmod +x scripts/security-check.sh
./scripts/security-check.sh
~~~

실행 결과:

~~~text
Linux Security Compliance Report
========================================

[FAIL] U-01 - Root 원격 로그인 제한
[PASS] U-02 - SSH 설정 확인
[FAIL] U-03 - 패스워드 최대 사용 기간
[FAIL] U-04 - Firewall 활성화
[PASS] U-05 - SSH 서비스 활성화 상태
[PASS] U-06 - 일반 사용자 계정 확인
[PASS] U-07 - 추가 UID 0 계정 존재 여부
[PASS] U-08 - /etc/passwd 파일 권한
[PASS] U-09 - /etc/shadow 파일 권한
[PASS] U-10 - SSH 서비스 실행 상태
...
[PASS] U-30 - 주요 보안 서비스 실행 상태

========================================
PASS : 21
FAIL : 9
~~~

현재 테스트 환경에서는 총 30개 항목 중 다음과 같은 결과가 확인되었습니다.

~~~text
PASS : 21
FAIL : 9
~~~

본 프로젝트는 진단 목적의 프로젝트입니다.

FAIL 항목이 발견되더라도 Script가 서버의 설정을 자동으로 변경하지 않습니다.

예를 들어 다음과 같은 설정을 자동으로 변경하지 않습니다.

- SSH 설정
- Firewall 설정
- SELinux 설정
- Password Policy
- 파일 권한

따라서 실제 운영 서버의 현재 보안 상태를 확인하고 필요한 조치를 별도의 운영 절차를 통해 수행할 수 있도록 구성했습니다.

---

## 8. HTML Report

TXT 형태의 결과를 사람이 쉽게 확인할 수 있도록 HTML Report를 자동 생성합니다.

실행:

~~~bash
chmod +x scripts/generate-report.sh
./scripts/generate-report.sh
~~~

생성 결과:

~~~text
reports/
├── security-report.txt
└── security-report.html
~~~

HTML Report에는 다음 정보가 포함됩니다.

- Total Checks
- PASS
- FAIL
- Compliance
- Individual Check Results

현재 테스트 결과:

~~~text
Total Checks : 30
PASS         : 21
FAIL         : 9
Compliance   : 70%
~~~

HTML Report는 GitHub Actions 실행 후 Artifact로 보관됩니다.

---

## 9. GitHub Actions

GitHub Actions를 이용하여 보안 점검 과정을 자동화했습니다.

Workflow 파일:

~~~text
.github/workflows/security-check.yml
~~~

실행 과정:

~~~text
git push
   ↓
GitHub Actions
   ↓
Checkout Repository
   ↓
security-check.sh
   ↓
security-report.txt
   ↓
generate-report.sh
   ↓
security-report.html
   ↓
Upload Artifact
~~~

Workflow:

~~~yaml
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
~~~

---

## 10. Self-hosted Runner

GitHub Actions 실행 환경으로 Linux 서버를 직접 사용하는 Self-hosted Runner를 구성했습니다.

구성:

~~~text
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
~~~

Runner 환경:

~~~text
Runner Name : devops-lab
OS          : Linux
Architecture: x64
~~~

Runner 실행:

~~~bash
./run.sh
~~~

GitHub Repository에서 다음 메뉴를 통해 Runner 상태를 확인할 수 있습니다.

~~~text
Settings
  ↓
Actions
  ↓
Runners
~~~

---

## 11. 실행 방법

### 11.1 Repository Clone

~~~bash
git clone https://github.com/dpskst/linux-security-compliance.git
cd linux-security-compliance
~~~

### 11.2 Script 실행 권한 설정

~~~bash
chmod +x scripts/security-check.sh
chmod +x scripts/generate-report.sh
~~~

### 11.3 보안 점검 실행

~~~bash
./scripts/security-check.sh
~~~

### 11.4 HTML Report 생성

~~~bash
./scripts/generate-report.sh
~~~

### 11.5 결과 확인

~~~bash
cat reports/security-report.txt
~~~

HTML 파일 확인:

~~~bash
ls -l reports/
~~~

---

## 12. GitHub Actions 결과

GitHub에 Push하면 자동으로 Workflow가 실행됩니다.

~~~text
Push
 ↓
Checkout
 ↓
Security Check
 ↓
Generate HTML Report
 ↓
Display Report
 ↓
Upload Artifact
~~~

GitHub Actions의 Artifact에서 다음 결과를 확인할 수 있습니다.

~~~text
security-compliance-report
├── security-report.txt
└── security-report.html
~~~

HTML Report는 Artifact를 다운로드한 후 브라우저에서 확인할 수 있습니다.

---

## 13. Troubleshooting

### 13.1 Report Permission 문제

초기 Script에서는 Report 경로를 절대경로로 설정했습니다.

~~~text
/root/project-05-security/reports/security-report.txt
~~~

하지만 GitHub Actions Self-hosted Runner는 `actions` 사용자로 Workflow를 실행하기 때문에 해당 경로에 파일을 생성하는 과정에서 Permission 문제가 발생했습니다.

수정:

~~~bash
REPORT="$(dirname "$0")/../reports/security-report.txt"
~~~

Script 위치를 기준으로 상대 경로를 사용하도록 변경하여 Repository 내부의 `reports` 디렉터리에 Report가 생성되도록 수정했습니다.

---

### 13.2 GitHub Actions YAML 오류

Workflow 작성 과정에서 YAML indentation 문제로 다음과 같은 오류가 발생했습니다.

~~~text
Invalid workflow file
You have an error in your yaml syntax
~~~

Workflow의 indentation 및 Artifact `path` 설정을 수정하여 해결했습니다.

최종적으로 TXT와 HTML Report를 모두 Artifact로 업로드하도록 구성했습니다.

---

## 14. 프로젝트 결과

본 프로젝트를 통해 Linux 서버의 보안 점검 과정을 자동화했습니다.

### 구현 결과

- 30개 Linux 보안 점검 항목 구현
- Bash 기반 보안 진단 Script 작성
- PASS / FAIL 결과 자동 생성
- TXT Report 생성
- HTML Report 생성
- GitHub Actions 자동 실행
- Self-hosted Runner 구성
- GitHub Actions Artifact 결과 보관

### 테스트 결과

~~~text
Total Checks : 30
PASS         : 21
FAIL         : 9
Compliance   : 70%
~~~

---

## 15. 주요 경험

### Linux Security

Linux 서버의 SSH, 사용자 계정, 파일 권한, Firewall, SELinux, Audit, Logging 등의 상태를 자동으로 점검하는 Script를 구현했습니다.

### Shell Script

Linux 시스템 정보를 수집하고 조건에 따라 PASS / FAIL을 판단하는 Bash Script를 작성했습니다.

### GitHub Actions

Git Push를 기준으로 보안 점검을 자동 실행하고 결과를 Artifact로 저장하는 자동화 환경을 구성했습니다.

### Self-hosted Runner

직접 관리하는 Linux 서버를 GitHub Actions의 실행 환경으로 구성했습니다.

### Security Automation

반복적으로 수행해야 하는 Linux 보안 점검 작업을 자동화하여 점검 과정과 결과를 표준화했습니다.

---

## 16. 향후 개선 방향

### 16.1 점검 항목 확대

현재 30개 항목에서 추가적인 Linux 보안 기준을 적용하여 점검 범위를 확대할 수 있습니다.

### 16.2 JSON Report

TXT / HTML Report 외에 JSON 형식의 결과를 생성하여 다른 시스템과 연계할 수 있도록 확장할 수 있습니다.

### 16.3 다중 서버 점검

여러 Linux 서버를 대상으로 동일한 보안 점검 Script를 실행하고 서버별 Compliance 상태를 중앙에서 관리하는 구조로 확장할 수 있습니다.

### 16.4 Monitoring 연계

Prometheus / Grafana와 연계하여 서버별 보안 Compliance 상태를 Dashboard로 시각화할 수 있습니다.

### 16.5 Ansible 연계

현재의 진단 기능과 별도로 Ansible을 이용한 보안 설정 자동화 기능으로 확장할 수 있습니다.

---

## 17. Repository

GitHub Repository

https://github.com/dpskst/linux-security-compliance
