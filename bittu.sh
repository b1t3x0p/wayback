#!/bin/bash

# Wayback Machine Sensitive File Extractor
# This tool extracts all archived URLs of a domain from the Wayback Machine and filters out URLs with potentially sensitive file extensions.

# Ensure the script uses Unix-style line endings
sed -i 's/\r$//' "$0"

# Prompt for the domain name.
read -p "Enter the domain (e.g., example.com): " domain

echo "Fetching all URLs from the Wayback Machine..."
# Fetch all URLs for the given domain.
curl -G "https://web.archive.org/cdx/search/cdx" \
  --data-urlencode "url=*.$domain/*" \
  --data-urlencode "collapse=urlkey" \
  --data-urlencode "output=text" \
  --data-urlencode "fl=original" \
  -o all_urls.txt

echo "Fetching URLs with specific file extensions..."
# Fetch only URLs ending with certain file extensions.
# (Added more extensions that may contain sensitive data.)
curl -G "https://web.archive.org/cdx/search/cdx" \
  --data-urlencode "url=*.$domain/*" \
  --data-urlencode "collapse=urlkey" \
  --data-urlencode "output=text" \
  --data-urlencode "fl=original" \
  --data-urlencode "filter=original:.*\.(xls|xml|xlsx|json|pdf|sql|doc|docx|pptx|txt|git|zip|tar\.gz|tgz|bak|7z|rar|log|cache|secret|db|backup|yml|gz|config|csv|yaml|md|md5|exe|dll|bin|ini|bat|sh|tar|deb|rpm|iso|img|env|apk|msi|dmg|tmp|crt|pem|key|pub|asc|swp|conf|lock|passwd|shadow|htpasswd|htaccess|bkp|old|crt|ovpn|sqlitedb|db3|kdbx|ps1|cfg|dat|rdp|cer|pfx|csr|vmdk|vdi|qcow2|ova|pem|ppk|cred|credentials)$" \
  -o filtered_urls.txt

echo "Done! Results saved to:"
echo "  - all_urls.txt (all URLs)"
echo "  - filtered_urls.txt (URLs with specific file extensions)"
