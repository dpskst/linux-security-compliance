# Linux Security Compliance Automation

Linux 서버의 주요 보안 설정 및 운영 상태를 자동으로 점검하고,
GitHub Actions를 통해 결과를 자동 생성 및 리포팅하는
Linux Security Compliance Automation 프로젝트입니다.

서버의 보안 설정을 직접 변경하지 않고 현재 상태를 진단하여
PASS / FAIL 형태로 결과를 제공하는 것을 목표로 합니다.

---

## 1. 프로젝트 개요

### 프로젝트 목적

Linux 서버의 보안 설정을 사람이 수동으로 하나씩 확인하는 대신
Shell Script를 이용하여 주요 보안 항목을 자동으로 점검합니다.

점검 결과는 텍스트 리포트와 HTML 리포트로 생성되며,
GitHub Actions를 통해 자동 실행할 수 있도록 구성했습니다.

### 주요 기능

- Linux 서버 보안 설정 자동 점검
- 30개 보안 점검 항목 제공
- PASS / FAIL 결과 출력
- 보안 점검 결과 TXT Report 생성
- HTML Report 자동 생성
- GitHub Actions 자동화
- Self-hosted Runner를 통한 내부 Linux 서버에서 실행
- GitHub Actions Artifact를 통한 결과 보관

---

## 2. 프로젝트 목표

본 프로젝트에서는 다음과 같은 Infrastructure / Security Automation 역량을 구현했습니다.

- Linux 시스템 보안 점검 자동화
- Shell Script 기반 시스템 진단
- GitHub Actions CI/CD 활용
- Self-hosted Runner 구성
- 자동화된 보안 리포트 생성
- 운영 서버의 보안 상태 가시화
- 반복적인 수동 점검 업무 자동화

---

## 3. 프로젝트 환경

| 구분 | 환경 |
|---|---|
| OS | Rocky Linux 8.10 |
| 서버 | devops-lab |
| Script | Bash Shell |
| CI/CD | GitHub Actions |
| Runner | GitHub Actions Self-hosted Runner |
| Repository | GitHub |
| Report | TXT / HTML |

---

## 4. 시스템 구성

```text
                    GitHub
                       |
                       | git push
                       v
              GitHub Actions
                       |
                       v
             Self-hosted Runner
              (devops-lab)
                       |
                       v
            security-check.sh
                       |
                       v
              30개 보안 점검
                       |
             +---------+---------+
             |                   |
             v                   v
     security-report.txt   generate-report.sh
                                 |
                                 v
                       security-report.html
                                 |
                                 v
                    GitHub Actions Artifact
