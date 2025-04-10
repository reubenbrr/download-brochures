#!/bin/bash

# Base URL
BASE_URL="https://assets.rolex.com/api/brochure/en"

# Create a folder for downloads
mkdir -p downloads

# Array of paths
paths=(
  "/land-dweller/M127334-0001" "/day-date/M228235-0055" "/lady-datejust/M279135RBR-0001"
  "/sky-dweller/M336935-0008" "/datejust/M126234-0051" "/oyster-perpetual/M134300-0006"
  "/cosmograph-daytona/M126508-0008" "/submariner/M124060-0001" "/sea-dweller/M126603-0001"
  "/deepsea/M136668LB-0001" "/yacht-master/M226627-0001" "/explorer/M226570-0001"
  "/air-king/M126900-0001" "/1908/M52508-0008" "/lady-datejust/M279384RBR-0004"
  "/explorer/M124270-0001" "/datejust/M126300-0005" "/datejust/M278344RBR-0021"
  "/yacht-master/M268622-0002" "/day-date/M228238-0069" "/cosmograph-daytona/M126509-0001"
  "/land-dweller/M127335-0001" "/cosmograph-daytona/M126518LN-0014" "/1908/M52506-0002"
  "/datejust/M126334-0014" "/sky-dweller/M336933-0001" "/cosmograph-daytona/M126505-0001"
  "/lady-datejust/M279174-0020" "/gmt-master-ii/M126711CHNR-0002" "/cosmograph-daytona/M126515LN-0006"
  "/oyster-perpetual/M277200-0017" "/deepsea/M136660-0005" "/day-date/M128238-0045"
  "/cosmograph-daytona/M126506-0001" "/sky-dweller/M336938-0008" "/gmt-master-ii/M126729VTNR-0001"
  "/submariner/M126613LB-0002" "/day-date/M128236-0018" "/datejust/M278384RBR-0008"
  "/datejust/M278288RBR-0041" "/submariner/M126618LN-0002" "/lady-datejust/M279383RBR-0003"
  "/cosmograph-daytona/M126519LN-0006" "/cosmograph-daytona/M126503-0003" "/gmt-master-ii/M126715CHNR-0002"
  "/sea-dweller/M126600-0002" "/gmt-master-ii/M126713GRNR-0001" "/gmt-master-ii/M126710GRNR-0003"
  "/land-dweller/M127286TBR-0001" "/datejust/M126203-0020" "/land-dweller/M127285TBR-0002"
  "/deepsea/M126067-0002" "/day-date/M228236-0012" "/datejust/M278343RBR-0016"
  "/1908/M52509-0002" "/cosmograph-daytona/M126598TBR-0001" "/datejust/M278241-0018"
  "/datejust/M126231-0020" "/datejust/M278285RBR-0005" "/explorer/M224270-0001"
  "/day-date/M128239-0005" "/cosmograph-daytona/M126589RBR-0001" "/submariner/M126610LV-0002"
  "/submariner/M126619LB-0003" "/datejust/M126331-0007" "/datejust/M126333-0010"
  "/sky-dweller/M336934-0001" "/yacht-master/M126655-0002" "/day-date/M228239-0033"
  "/land-dweller/M127235-0001" "/yacht-master/M126621-0002" "/lady-datejust/M279173-0012"
  "/datejust/M126281RBR-0016" "/1908/M52508-0006" "/gmt-master-ii/M126720VTNR-0001"
  "/yacht-master/M126622-0001" "/datejust/M278240-0018" "/submariner/M126610LN-0001"
  "/land-dweller/M127234-0001" "/cosmograph-daytona/M126500LN-0001" "/sky-dweller/M336239-0002"
  "/cosmograph-daytona/M126535TBR-0002" "/day-date/M128395TBR-0032" "/day-date/M228348RBR-0002"
  "/day-date/M228238-0042" "/oyster-perpetual/M276200-0001" "/datejust/M278274-0018"
  "/datejust/M126334-0002" "/datejust/M126200-0002" "/datejust/M278273-0019"
  "/day-date/M128399TBR-0029" "/day-date/M128235-0009" "/datejust/M126333-0019"
  "/gmt-master-ii/M126718GRNR-0001" "/yacht-master/M226659-0002" "/land-dweller/M127336-0001"
  "/oyster-perpetual/M126000-0013" "/datejust/M126284RBR-0011" "/oyster-perpetual/M124200-0007"
  "/gmt-master-ii/M126710BLNR-0003"
)

# Create a log file for errors
ERROR_LOG="error.log"
> "$ERROR_LOG" # Clear the log file

# Loop through paths
for path in "${paths[@]}"; do
  # Convert path to lowercase
  lower_path=$(echo "$path" | tr '[:upper:]' '[:lower:]')
  
  # Construct the URL
  url="${BASE_URL}${lower_path}.pdf"

  echo "Downloading: $url"
  
  # Define the output filename
  filename="downloads/$(basename "$lower_path").pdf"
  # Download the file and check the HTTP status
  http_status=$(curl -o "$filename" -w "%{http_code}" -s "$url")
  
  # Log an error if the HTTP status is 404
  if [[ "$http_status" == "404" ]]; then
    echo "Error: $url returned 404" >> "$ERROR_LOG"
    rm -f "$filename" # Remove the file if it was created
  fi
    if [[ "$http_status" == "400" ]]; then
    echo "Error: $url returned 400" >> "$ERROR_LOG"
    rm -f "$filename" # Remove the file if it was created
  fi

  curl -o "$filename" "$url"

done

echo "Download complete!"