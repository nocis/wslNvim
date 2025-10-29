1. Docker desktop doesn't require HYPER-V
2. uninstall docker desktop
3. wsl --shutdown
4. wsl --status
5. wsl --unregister docker-desktop
6. rm -f ~/.docker/contexts ~/.docker/features.json
7. sudo rm /usr/local/lib/docker/cli-plugins/docker-*
8. wsl.exe --shutdown
9. netsh winsock reset
10. reboot
11. reinstall docker desktop
12. reboot

old disk:
1. diskpart
2. select vdisk file="a\b\c.vhdx"
3. compact vdisk
4. detach vdisk
5. delete data disk file
