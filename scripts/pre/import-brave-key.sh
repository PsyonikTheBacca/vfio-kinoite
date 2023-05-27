set -oue pipefail
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
rpm-ostree install rpmrebuild
mkdir brave && cd brave
wget https://brave-browser-rpm-release.s3.brave.com/x86_64/brave-keyring-1.11-1.noarch.rpm -O brave-keyring.rpm
rpmrebuild --change-spec-post="sed 's/service atd start//;s/echo \"sh \/etc\/cron.daily\/brave-key-updater\" | at now + 2 minute > \/dev\/null 2>&1//'" --define "_rpmdir $(pwd)"  -p ./brave-keyring.rpm
rpm-ostree install ./noarch/brave-keyring-1.11-1.noarch.rpm --uninstall=rpmrebuild
