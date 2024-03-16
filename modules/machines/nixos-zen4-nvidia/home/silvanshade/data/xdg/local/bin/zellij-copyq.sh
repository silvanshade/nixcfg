#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

copyq add - && copyq select 0
