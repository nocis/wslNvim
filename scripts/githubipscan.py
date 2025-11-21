# sudo .tmpenv/bin/python githubipscan.py
# run wsl in admin mode

import base64
import ipaddress
import json
import os
import subprocess
import sys
import time
from concurrent.futures import ThreadPoolExecutor
from itertools import islice
from typing import cast


def run_cmd_as_admin_wsl(command: str) -> bool:
    """
    uac admin
    """
    powershell_full_path = (
        "/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe"
    )

    # -------------------------- Base64 for replace('"', '\\"').replace("`", "``") --------------------------
    try:
        command_utf16 = command.encode("utf-16-le")
        command_base64 = base64.b64encode(command_utf16).decode("utf-8")

        powershell_cmd = [
            powershell_full_path,
            "-NoProfile",
            "-ExecutionPolicy",
            "Bypass",
            "-Command",
            f'Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -EncodedCommand {command_base64}" -Verb RunAs -Wait -PassThru',
        ]

        print("⚠️  Important Notice:")
        print(
            "1. A UAC authorization window will pop up next - please be sure to click 'Allow'"
        )
        print(
            "2. Please close 360, Huorong, Windows Defender, and other antivirus software first"
        )
        print("3. Do not open the hosts file with Notepad/VS Code")
        _ = input("Press Enter to start execution...")

        result = subprocess.run(
            powershell_cmd,
            capture_output=True,
            text=True,
            encoding="utf-8",
            timeout=180,
            check=False,  # let user see the powershell log
        )
        if result.returncode == 0:
            return True
        else:
            return False

    except Exception as e:
        print(f"Error Message: {str(e)}")
        return False


def get_github_meta():
    try:
        result = subprocess.run(
            ["curl", "-s", "https://api.github.com/meta"], capture_output=True
        )
        return result.stdout.decode().strip()
    except subprocess.SubprocessError:
        return ""


def cidr_to_ips(cidr_list: list[str], max_ips_per_cidr: int = 10):
    ips: list[str] = []
    for cidr in cidr_list:
        try:
            network = ipaddress.ip_network(cidr)
            if network.version != 4:
                continue
            for ip in islice(network.hosts(), max_ips_per_cidr):
                ips.append(str(ip))
        except AttributeError:
            continue
    return ips


def test_ip(ip: str):
    try:
        result = subprocess.run(
            [
                "curl",
                "-v",
                "-I",
                "-s",
                "-k",
                "-H",
                "Host: github.com",
                f"https://{ip}",
                "-w",
                "%{http_code},%{time_total}",
                "-o",
                "/dev/null",
            ],
            timeout=5,
            capture_output=True,
        )
        stdout = result.stdout.decode("utf-8").strip()
        if not stdout or "," not in stdout:
            return ip, False, float("inf")

        http_code_str, time_total_str = stdout.split(",", 1)
        http_code = int(http_code_str) if http_code_str.isdigit() else 0

        response_time = (
            float(time_total_str)
            if time_total_str.replace(".", "").isdigit()
            else float("inf")
        )

        ssl_details = result.stderr.decode("utf-8")
        # curel-v, need to check cn, ip may indicate cn: *.github-debug.com

        return (
            ip,
            http_code in [200, 301, 302, 307, 308] and ("CN=github.com" in ssl_details),
            round(response_time, 3),
        )
    except subprocess.TimeoutExpired:
        return ip, False, float("inf")


def is_admin():
    """sudo check"""
    try:
        return os.geteuid() == 0
    except AttributeError:
        return False


def update_hosts(working_ips: list[str]):
    win_hosts_path = r"C:\Windows\System32\drivers\etc\hosts"
    target_domain = "github.com"

    formatted_lines = [f"{ip}  {target_domain}" for ip in working_ips]
    content_to_write = f"\n{'\n'.join(formatted_lines)}\n"

    command = f'''
    $isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    if (-not $isAdmin) {{
        Write-Host "`n❌ Error: not Admin" -ForegroundColor Red;
        Read-Host -Prompt "Close window";
        exit 1;
    }}
    
    Write-Host "✅ Admin confirmed" -ForegroundColor Green;
    
    $hostsPath = "{win_hosts_path}";
    $hostsBakPath = "{win_hosts_path}.bak";

    
    try {{
        Write-Host "`n🔍 backup hosts：$hostsBakPath" -ForegroundColor Cyan;
        if (-not (Test-Path $hostsBakPath)) {{
            Copy-Item -Path $hostsPath -Destination $hostsBakPath -Force -ErrorAction Stop
        }}
        else{{
            Remove-Item -Path $hostsPath -Force -ErrorAction Stop
            Copy-Item -Path $hostsBakPath -Destination $hostsPath -Force -ErrorAction Stop
        }}


        Write-Host "`n🔍 hosts path：$hostsPath" -ForegroundColor Cyan;
        if (-not (Test-Path $hostsPath)) {{
            throw "hosts does not exist ：$hostsPath";
        }}
    
        Write-Host "`n📋 hosts before write：" -ForegroundColor Cyan;
        $existing = Get-Content $hostsPath -Tail 10 -ErrorAction Stop;
        $existing | ForEach-Object {{ Write-Host "  $_" -ForegroundColor Gray; }}
    
        Write-Host "`n🔥 Writing..." -ForegroundColor Red;
        $contentToWrite = "{content_to_write}";  # new line
        $contentToWrite | Out-File -FilePath $hostsPath -Append -Force -Encoding UTF8 -ErrorAction Stop;
    
        Write-Host "`n✅ Write complete!：" -ForegroundColor Green;
        $newContent = Get-Content $hostsPath -Tail 10 -ErrorAction Stop;
        $newContent | ForEach-Object {{ Write-Host "  $_" -ForegroundColor Gray; }}
    
        Write-Host "`n🎉 Successful！hosts updated" -ForegroundColor Green;

        Write-Host "`n🔥 flush dns..." -ForegroundColor Green
        ipconfig /flushdns
    
    }} catch {{
        Write-Host "`n❌ Write failed! Error details:" -ForegroundColor Red;
        Write-Host "  Error message: $($_.Exception.Message)" -ForegroundColor Red;
        Write-Host "  Error location: $($_.InvocationInfo.Line)" -ForegroundColor Red;
    }}
    
    Read-Host -Prompt "`n📋 misson complete. Press Enter..."
    '''

    _ = run_cmd_as_admin_wsl(command)


def filterWorkingIps(ips: list[str]):
    with ThreadPoolExecutor(max_workers=20) as executor:
        results = list(executor.map(test_ip, ips))

    return [
        ip
        for ip, _ in sorted(
            [(ip, time) for ip, status, time in results if status],
            key=lambda x: x[1],
        )
    ]


def main():
    if not is_admin():
        print("sudo")
        sys.exit(1)

    meta = get_github_meta()
    cidr_list = cast(list[str], json.loads(meta)["web"])
    ips = cidr_to_ips(cidr_list)

    working_ips = filterWorkingIps(ips)
    time.sleep(2)
    working_ips_validate = filterWorkingIps(working_ips)
    time.sleep(2)
    working_ips = filterWorkingIps(working_ips_validate)
    time.sleep(2)
    working_ips_validate = filterWorkingIps(working_ips)
    time.sleep(2)
    working_ips = filterWorkingIps(working_ips_validate)
    update_hosts(working_ips)


if __name__ == "__main__":
    main()
