#!/usr/bin/env python3
"""Parse Helm charts and their values files into JSON format."""

import argparse
import json
import os
import sys
from pathlib import Path

try:
    import yaml
except ImportError:
    print("Error: PyYAML is required. Install with: pip install PyYAML", file=sys.stderr)
    sys.exit(1)


def find_chart_directories(charts_root: Path, chart_filter: str = None):
    """Find all chart directories, optionally filtered by name."""
    chart_dirs = []
    
    if not charts_root.exists():
        print(f"Error: Charts root directory does not exist: {charts_root}", file=sys.stderr)
        sys.exit(1)
    
    for item in charts_root.iterdir():
        if item.is_dir():
            chart_yaml = item / "Chart.yaml"
            if chart_yaml.exists():
                # Apply chart filter if provided
                if chart_filter and item.name != chart_filter:
                    continue
                chart_dirs.append(item)
    
    return sorted(chart_dirs)


def find_values_files(chart_dir: Path, values_filter: str = None):
    """Find all values.yaml files in a chart directory, excluding linter_values.yaml."""
    values_files = []
    
    for values_file in chart_dir.glob("*values.yaml"):
        if values_file.name == "linter_values.yaml":
            continue
        
        # Apply values filter if provided
        if values_filter and values_filter not in values_file.name:
            continue
            
        # Store relative filename only
        values_files.append(values_file.name)
    
    return sorted(values_files)


def parse_chart_yaml(chart_yaml_path: Path):
    """Parse Chart.yaml and extract name, type, and version."""
    try:
        with open(chart_yaml_path, 'r') as f:
            chart_data = yaml.safe_load(f)
        
        return {
            "name": chart_data.get("name", ""),
            "type": chart_data.get("type", ""),
            "version": chart_data.get("version", "")
        }
    except Exception as e:
        print(f"Error parsing {chart_yaml_path}: {e}", file=sys.stderr)
        return None


def main():
    parser = argparse.ArgumentParser(description="Parse Helm charts and values files to JSON")
    parser.add_argument("charts_root", help="Root directory containing the charts")
    parser.add_argument("--chart-filter", help="Filter to apply to chart names")
    parser.add_argument("--values-filter", help="Filter to apply to values filenames")
    
    args = parser.parse_args()
    
    charts_root = Path(args.charts_root)
    chart_directories = find_chart_directories(charts_root, args.chart_filter)
    
    if not chart_directories:
        print(f"Warning: No charts found in {charts_root}", file=sys.stderr)
    
    all_charts = []
    
    for chart_dir in chart_directories:
        chart_yaml_path = chart_dir / "Chart.yaml"
        chart_info = parse_chart_yaml(chart_yaml_path)
        
        if chart_info is None:
            continue
        
        values_files = find_values_files(chart_dir, args.values_filter)
        
        # Skip charts with no matching values files
        if not values_files:
            continue
        
        chart_info["values"] = values_files
        all_charts.append(chart_info)
    
    # Output the final JSON structure
    output = {"charts": all_charts}
    print(json.dumps(output, separators=(',', ':')))


if __name__ == "__main__":
    main()
