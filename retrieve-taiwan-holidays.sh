#!/usr/bin/env bash

# Data Source: https://data.gov.tw/dataset/123662

# Data extraction logic:
#
#   1. fetch original csv input from open data
#   2. remove data before 2025 and regular holidays (non-adjusted holidays on Saturday or Sunday)
#   3. convert CSV to JSON with Python scripts
#   4. prettify JSON output with jq

curl -fsSL "https://data.ntpc.gov.tw/api/datasets/308dcd75-6434-45bc-a95f-584da4fed251/csv/file" | \
  sed -e '/201[0-9]/d' -e '/202[0-4]/d' -e '/星期六、星期日/d' | \
  python3 -c 'import csv, json, sys; print(json.dumps([dict(r) for r in csv.DictReader(sys.stdin)]))' | \
  jq '.'