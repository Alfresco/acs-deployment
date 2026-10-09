# Test Dashboard Naming Convention & XAT Cloning Guide

## Dashboard Naming Pattern

All test dashboards follow this standardized naming convention:

```
{Release} - Test Dashboard ACS {ACS Version}, APS {APS Version}
```

### Format Breakdown

| Component | Example | Notes |
|-----------|---------|-------|
| Release Name | Oxygen, Nitrogen, Neon, Lithium | Release codename |
| Separator | ` - ` (space-dash-space) | Consistent spacing |
| Prefix | "Test Dashboard" | Standard prefix |
| ACS Abbreviation | ACS | Alfresco Content Services |
| ACS Version | 25.4, 26.2, 26.0 | Release version |
| Comma | `, ` | Comma with space |
| APS Abbreviation | APS | Alfresco Process Services |
| APS Version | 25.4, 26.2, 26.0 | Release version |

### Examples

#### Correct Format ✅
- `Oxygen - Test Dashboard ACS 25.4, APS 25.4`
- `Nitrogen - Test Dashboard ACS 26.2, APS 26.2`
- `Neon - Test Dashboard ACS 26.0, APS 26.0`
- `Helium - Test Dashboard ACS 23.7, APS 24.7`
- `Lithium - Test Dashboard ACS 24.4, APS 24.4`

#### Incorrect Format ❌
- ~~`Oxygen- Test Dashboard 25.4`~~ (Missing "ACS/APS", missing space after dash)
- ~~`Oxygen Test Dashboard ACS 25.4`~~ (Missing " - " separator)
- ~~`Oxygen - Test Dashboard 25.4, 25.4`~~ (Missing ACS/APS labels)
- ~~`Oxygen - Dashboard ACS 25.4 APS 25.4`~~ (Missing "Test" in name)

---

## Confluence Page URL Structure

### URL Format
```
https://hyland.atlassian.net/wiki/spaces/{SPACE_KEY}/pages/{PAGE_ID}/{TITLE_URLENCODED}
```

### Oxygen Dashboard URLs

**Before Update**:
- Page Title: `Oxygen- Test Dashboard 25.4`
- URL: `...pages/4213463408/Oxygen-+Test+Dashboard+25.4`
- Status: ❌ Non-standard naming

**After Update**:
- Page Title: `Oxygen - Test Dashboard ACS 25.4, APS 25.4`
- URL: `...pages/4213463408/Oxygen+-+Test+Dashboard+ACS+25.4+APS+25.4`
- Status: ✅ Matches Nitrogen convention

### Live Examples

| Release | Page Title | Page ID | Space |
|---------|-----------|---------|-------|
| Nitrogen (Reference) | Nitrogen - Test Dashboard ACS 26.2, APS 26.2 | 4176348976 | TECH |
| Oxygen (Updated) | Oxygen - Test Dashboard ACS 25.4, APS 25.4 | 4213463408 | ~61a51d28977c5b007200a0a0 |
| Helium (Template) | Helium Test Dashboard - ACS 23.7 GA APS 24.7 GA | 3914105412 | TECH |

---

## Xray Test Plan (XAT) Cards - Cloning Guide

### What is XAT?

**XAT** = **X**ray **A**utomation **T**esting framework

XAT cards are Jira issues (of type "Test Plan" or "Test Set") that contain:
- Test scenarios and cases
- Automation configuration
- Execution results and metrics
- Links to components being tested

### XAT Card Types

| Type | ID Pattern | Purpose | Example |
|------|-----------|---------|---------|
| Test Plan | XAT-19595, XAT-19614 | High-level test plan for a release | XAT-19595: Oxygen Test Plan |
| Test Set | XAT-19547, XAT-19553 | Grouped test cases | XAT-19547: ACS Core Modules |
| Test Execution | XAT-19557, XAT-19559 | Manual execution record | XAT-19557: APS Manual Testing |

### Nitrogen XAT Structure (Reference)

```
Main Test Plans:
├── XAT-19595 - Nitrogen Test Plan (ACS 26.2)
└── XAT-19614 - Nitrogen Test Plan (APS 26.2)

Installation & Upgrade Testing:
├── XAT-19547 - ACS Modules to Scan
├── XAT-19553 - ZIP Installation Tests
├── XAT-19554 - Upgrade Stack #1 (23.x → 26.2)
├── XAT-19555 - Upgrade Stack #2 (25.x → 26.2)
├── XAT-19556 - Upgrade Stack #3 (7.x → 26.2)
├── XAT-19590 - Upgrade Stack #4
├── XAT-19591 - Upgrade Stack #5
└── XAT-19592 - Upgrade Stack #6

Release Components (20+ components):
├── XAT-19543 - Share Enterprise
├── XAT-19544 - Governance Services
├── XAT-19546 - Transform Service
├── XAT-19596 - Search Enterprise
└── ... (more components)

APS Testing:
├── XAT-19557 - APS Manual Testing #1
├── XAT-19646 - APS Manual Testing #2
├── XAT-19647 - APS Manual Testing #3
└── XAT-19648 - APS Manual Testing #4

Regression Testing:
├── XAT-19562 - Outlook Integration
└── XAT-19563 - Office Services
```

### Oxygen XAT Structure (To Be Created)

Following the same pattern, Oxygen should have:

```
Main Test Plans:
├── XAT-19595 (Clone) - Oxygen Test Plan (ACS 25.4)
└── XAT-19614 (Clone) - Oxygen Test Plan (APS 25.4)

Installation & Upgrade Testing:
├── XAT-19547 (Clone) - ACS Modules to Scan
├── XAT-19553 (Clone) - ZIP Installation Tests
├── XAT-19554 (Clone) - Upgrade Stack #1
├── XAT-19555 (Clone) - Upgrade Stack #2
├── XAT-19556 (Clone) - Upgrade Stack #3
├── XAT-19590 (Clone) - Upgrade Stack #4
├── XAT-19591 (Clone) - Upgrade Stack #5
└── XAT-19592 (Clone) - Upgrade Stack #6

Release Components (update versions):
├── ACS components tests
└── ... (clone and update version references)

APS Testing:
└── Similar to Nitrogen pattern

Regression Testing:
└── Similar to Nitrogen pattern
```

---

## XAT Card Cloning Process

### Step 1: Identify Cards to Clone

From Nitrogen dashboard, identify all XAT cards to clone:

**Primary Cards** (2):
- XAT-19595 (Main ACS test plan)
- XAT-19614 (Main APS test plan)

**Installation & Upgrade Cards** (6):
- XAT-19554 through XAT-19592 (All upgrade stacks)

**Component Cards** (20+):
- All XAT cards in Release Components section

**APS Cards** (4):
- XAT-19557, XAT-19646, XAT-19647, XAT-19648

**Regression Cards** (4):
- XAT-19562, XAT-19563, and others

### Step 2: Clone Instructions

**How to Clone an XAT Card**:

1. **Open** the original Xray test plan (e.g., XAT-19595)
2. **Click** "More" → "Clone Issue" (or use Jira keyboard shortcut `c`)
3. **Configure**:
   - **Project**: XRAY (or appropriate project)
   - **Issue Type**: Test Plan (or same as source)
   - **Summary**: Update release name
     - From: `Nitrogen Test Plan (ACS 26.2 GA)`
     - To: `Oxygen Test Plan (ACS 25.4 GA)`
   - **Test Cases**: Copy existing test cases
   - **Automation**: Adjust for new versions as needed
4. **Update**:
   - Release version references
   - Component versions
   - Upgrade paths (if applicable)
5. **Create** the cloned issue
6. **Note** the new XAT ID (e.g., XAT-19700)

### Step 3: Link Cloned Cards to Dashboard

Update Oxygen dashboard with cloned XAT card IDs:

```html
<!-- In dashboard Jira Test Task column -->
<a href="https://hyland.atlassian.net/browse/XAT-19700">XAT-19700</a>

<!-- Update xrayTestPlanIds in config -->
config.xrayTestPlanIds = {
  acs: 'XAT-19700',  // Cloned from XAT-19595
  aps: 'XAT-19701',  // Cloned from XAT-19614
}
```

---

## Configuration Update Guide

### In Tool Configuration

Update `oxygen-test-dashboard-creator.js`:

```javascript
config: {
  releaseName: 'Oxygen',                    // ← No dash after name
  acsVersion: '25.4',
  apsVersion: '25.4',
  xrayTestPlanIds: {
    acs: 'XAT-19595',                      // ← Primary ACS plan
    aps: 'XAT-19614',                      // ← Primary APS plan
  },
  // After cloning, update to:
  // acs: 'XAT-19700',  (new cloned ID)
  // aps: 'XAT-19701',  (new cloned ID)
}
```

### In Confluence Dashboard

Update dashboard header with cloned XAT IDs:

```html
<tr>
<th><strong>Test Plan (Xray)</strong></th>
<td>
<a href="https://hyland.atlassian.net/browse/XAT-19700">XAT-19700</a>
<a href="https://hyland.atlassian.net/browse/XAT-19701">XAT-19701</a>
</td>
</tr>
```

---

## Naming Guidelines Summary

### Do's ✅
- Use dash with spaces: ` - ` (not `-` or `--`)
- Include ACS version: `ACS 25.4`
- Include APS version: `APS 25.4`
- Use release codenames: Oxygen, Nitrogen, Neon, Lithium
- Separate components with comma and space: `, `

### Don'ts ❌
- Don't omit ACS/APS labels
- Don't use different separators (use ` - `)
- Don't include GA or version numbers in release name
- Don't mix formats between dashboards
- Don't use underscores or other special characters

### Format Verification Checklist

For each new dashboard, verify:

- [ ] Matches pattern: `{Release} - Test Dashboard ACS {Version}, APS {Version}`
- [ ] Release name has no dash (Oxygen, not Oxygen-)
- [ ] Separator is ` - ` with spaces
- [ ] "Test Dashboard" text present
- [ ] ACS version specified
- [ ] APS version specified
- [ ] Comma with space between versions
- [ ] Page URL reflects title correctly
- [ ] XAT cards are cloned and IDs updated
- [ ] Dashboard section references use new XAT IDs

---

## Examples: Before and After

### Oxygen Dashboard Migration

**Before Update** ❌
```
Title: Oxygen- Test Dashboard 25.4
URL: .../Oxygen-+Test+Dashboard+25.4
Test Plan: XAT-19238 (generic reference)
Components: Generic test tasks (4 total)
Structure: Basic (4 sections)
```

**After Update** ✅
```
Title: Oxygen - Test Dashboard ACS 25.4, APS 25.4
URL: .../Oxygen+-+Test+Dashboard+ACS+25.4+APS+25.4
Test Plan: XAT-19595, XAT-19614 (specific cloned plans)
Components: Detailed coverage (30+ components)
Structure: Enterprise-grade (9 sections)
```

### Nitrogen Dashboard (Reference) ✅
```
Title: Nitrogen - Test Dashboard ACS 26.2, APS 26.2
URL: .../Nitrogen+-+Test+Dashboard+ACS+26.2+APS+26.2
Test Plan: XAT-19595, XAT-19614 (original plans)
Components: Full coverage (30+ components)
Structure: Enterprise-grade (9 sections)
```

---

## Migration Path for Other Releases

To create dashboards for Neon, Lithium, or future releases:

1. **Clone** Nitrogen dashboard structure
2. **Rename** following pattern: `{Release} - Test Dashboard ACS {Version}, APS {Version}`
3. **Clone** all Nitrogen XAT cards
4. **Update** cloned XAT cards with new release information
5. **Link** cloned XAT IDs to dashboard
6. **Update** component versions in tables
7. **Verify** naming consistency across all pages

---

## Current Status

### Completed ✅
- [x] Oxygen dashboard renamed to correct format
- [x] Tool updated with new naming pattern
- [x] Configuration supports multiple XAT plans
- [x] Page content generation uses correct format
- [x] Documentation of naming convention
- [x] Nitrogen reference structure documented

### Pending ⏳
- [ ] Clone all XAT cards for Oxygen (manual Jira operation)
- [ ] Update dashboard with cloned XAT IDs
- [ ] Populate component version tables
- [ ] Finalize testing window dates
- [ ] Assign delivery teams and owners

---

## Quick Reference

| Release | Dashboard Name | Page ID | XAT IDs (ACS/APS) |
|---------|---|---|---|
| Oxygen | Oxygen - Test Dashboard ACS 25.4, APS 25.4 | 4213463408 | XAT-19595 / XAT-19614 |
| Nitrogen | Nitrogen - Test Dashboard ACS 26.2, APS 26.2 | 4176348976 | XAT-19595 / XAT-19614 |
| Helium | Helium - Test Dashboard ACS 23.7, APS 24.7 | 3914105412 | (original) |

---

Generated: July 27, 2026  
Version: 1.0
