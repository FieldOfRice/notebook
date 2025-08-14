
docker exec -i notebooks python - <<EOF
from importlib.metadata import distributions
import os
import time

packages = []
for dist in distributions():
    try:
        install_time = os.path.getctime(dist._path)
    except Exception:
        install_time = 0  # unknown fallback
    packages.append((dist.metadata['Name'], dist.version, install_time))

# Sort: by datetime first, then by package name
packages_sorted = sorted(packages, key=lambda x: (x[2], x[0].lower()))

print(f"{'Package':<40} {'Version':<15} {'Installed / Modified Time'}")
print("-" * 80)
for name, version, ctime in packages_sorted:
    readable_time = time.ctime(ctime) if ctime > 0 else "Unknown"
    print(f"{name:<40} {version:<15} {readable_time}")
EOF

# pipdeptree -p jupyter_ai

