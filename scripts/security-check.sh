#!/bin/bash

REPORT="/root/project-05-security/reports/security-report.txt"

PASS=0
FAIL=0

echo "========================================" | tee "$REPORT"
echo " Linux Security Compliance Report" | tee -a "$REPORT"
echo "========================================" | tee -a "$REPORT"
echo "" | tee -a "$REPORT"

check_result() {
    local ID="$1"
    local NAME="$2"
    local RESULT="$3"

    if [ "$RESULT" = "PASS" ]; then
        echo "[PASS] $ID - $NAME" | tee -a "$REPORT"
        PASS=$((PASS + 1))
    else
        echo "[FAIL] $ID - $NAME" | tee -a "$REPORT"
        FAIL=$((FAIL + 1))
    fi
}

# U-01 Root 원격 로그인 제한
ROOT_LOGIN=$(sshd -T 2>/dev/null | grep "^permitrootlogin ")

if echo "$ROOT_LOGIN" | grep -qi "no"; then
    check_result "U-01" "Root 원격 로그인 제한" "PASS"
else
    check_result "U-01" "Root 원격 로그인 제한" "FAIL"
fi

# U-02 SSH 설정 확인
if command -v sshd >/dev/null 2>&1; then
    check_result "U-02" "SSH 설정 확인" "PASS"
else
    check_result "U-02" "SSH 설정 확인" "FAIL"
fi

# U-03 패스워드 최대 사용 기간
PASS_MAX=$(grep "^PASS_MAX_DAYS" /etc/login.defs | awk '{print $2}')

if [ -n "$PASS_MAX" ] && [ "$PASS_MAX" -le 90 ]; then
    check_result "U-03" "패스워드 최대 사용 기간" "PASS"
else
    check_result "U-03" "패스워드 최대 사용 기간" "FAIL"
fi

# U-04 Firewall 활성화
if systemctl is-active --quiet firewalld; then
    check_result "U-04" "Firewall 활성화" "PASS"
else
    check_result "U-04" "Firewall 활성화" "FAIL"
fi

# U-05 SSH 서비스 활성화
if systemctl is-enabled --quiet sshd 2>/dev/null; then
    check_result "U-05" "SSH 서비스 활성화 상태" "PASS"
else
    check_result "U-05" "SSH 서비스 활성화 상태" "FAIL"
fi

# U-06 불필요한 계정 점검
SYSTEM_ACCOUNTS=$(awk -F: '$3 >= 1000 && $3 < 65534 {print $1}' /etc/passwd)

if [ -n "$SYSTEM_ACCOUNTS" ]; then
    check_result "U-06" "일반 사용자 계정 확인" "PASS"
else
    check_result "U-06" "일반 사용자 계정 확인" "FAIL"
fi

# U-07 UID 0 계정 점검
UID_ZERO=$(awk -F: '$3 == 0 {print $1}' /etc/passwd | grep -v "^root$")

if [ -z "$UID_ZERO" ]; then
    check_result "U-07" "추가 UID 0 계정 존재 여부" "PASS"
else
    check_result "U-07" "추가 UID 0 계정 존재 여부" "FAIL"
fi

# U-08 /etc/passwd 파일 권한
PASSWD_PERM=$(stat -c "%a" /etc/passwd)

if [ "$PASSWD_PERM" -le 644 ]; then
    check_result "U-08" "/etc/passwd 파일 권한" "PASS"
else
    check_result "U-08" "/etc/passwd 파일 권한" "FAIL"
fi

# U-09 /etc/shadow 파일 권한
SHADOW_PERM=$(stat -c "%a" /etc/shadow)

if [ "$SHADOW_PERM" -le 640 ]; then
    check_result "U-09" "/etc/shadow 파일 권한" "PASS"
else
    check_result "U-09" "/etc/shadow 파일 권한" "FAIL"
fi

# U-10 SSH 서비스 상태
if systemctl is-active --quiet sshd; then
    check_result "U-10" "SSH 서비스 실행 상태" "PASS"
else
    check_result "U-10" "SSH 서비스 실행 상태" "FAIL"
fi
echo "" | tee -a "$REPORT"
echo "========================================" | tee -a "$REPORT"
echo "PASS : $PASS" | tee -a "$REPORT"
echo "FAIL : $FAIL" | tee -a "$REPORT"
echo "========================================" | tee -a "$REPORT"
