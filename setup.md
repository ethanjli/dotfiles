# Setup

Additional setup instructions

## Work around graphics driver issues

Using `sudo rpm-ostree kargs --editor`, add the following kernel arguments:

- `amdgpu.sg_display=0`: from https://community.frame.work/t/tracking-graphical-corruption-in-fedora-39-amd-3-03-bios/39073/52

## Work around battery drainage issues

Run:

Using `sudo rpm-ostree kargs --editor`, add the following kernel arguments:

- `acpi_osi="!Windows 2020"`: from https://wiki.archlinux.org/title/Framework_Laptop_13#Suspend
- `rtc_cmos.use_acpi_alarm=1`: from https://wiki.archlinux.org/title/Framework_Laptop_13#Suspend-then-hibernate_on_AMD_version and https://community.frame.work/t/resolved-systemd-suspend-then-hibernate-wakes-up-after-5-minutes/39392
- `rcutree.enable_rcu_lazy=1`: from https://community.frame.work/t/tracking-linux-battery-life-tuning/6665/595

## Work around sleep issues

Make a udev rule at `/etc/udev/rules.d/20-suspend-fixes.rules` with the contents from https://community.frame.work/t/tracking-framework-amd-ryzen-7040-series-lid-wakeup-behavior-feedback/39128/45
