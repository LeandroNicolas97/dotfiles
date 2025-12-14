#!/bin/bash

# Get all active workspaces with their info
workspaces=$(hyprctl workspaces -j | jq -r '.[] | "\(.id):\(.windows) ventanas - \(.lastwindowtitle // "Vacío")"' | sort -n)

# Show in wofi and get selection
selected=$(echo "$workspaces" | wofi --dmenu --prompt "Cambiar a workspace:" --height 300 --width 600)

# Extract workspace ID from selection
if [ -n "$selected" ]; then
    workspace_id=$(echo "$selected" | cut -d':' -f1)
    hyprctl dispatch workspace "$workspace_id"
fi
