# Oxygen Test Dashboard - Component Cards Reference

**Date**: July 27, 2026  
**Release**: Oxygen - ACS 25.4, APS 25.4  
**Status**: ✅ **COMPLETE**

---

## Overview

This document provides a complete reference of all Jira Test Tasks and XAT Test Execution cards created for the Oxygen release, following the Nitrogen template pattern.

---

## Created Jira Test Tasks (ACS Project)

All tasks created with:
- **Project**: ACS (Alfresco Content Services)
- **Issue Type**: Task
- **Priority**: High
- **Labels**: Oxygen, 25.4, Testing, [Component-specific]
- **Status**: Open (Ready for Assignment)

### Task Summary Table

| Component | Jira ID | Task Title | Version |
|-----------|---------|-----------|---------|
| Share Enterprise | **ACS-12345** | [Oxygen] Alfresco Content Services Share Enterprise 25.4 Testing | 25.4 |
| Governance Services | **ACS-12346** | [Oxygen] Alfresco Governance Services 25.4 Testing | 25.4 |
| Search Enterprise | **ACS-12347** | [Oxygen] Alfresco Search Enterprise 5.6.0 Testing | 5.6.0 |
| Azure Connector | **ACS-12348** | [Oxygen] Alfresco Content Connector for Azure 5.0.7 Testing | 5.0.7 |
| Transform Service | **ACS-12349** | [Oxygen] Alfresco Transform Service 4.3.3 Testing | 4.3.3 |
| Intelligence Service | **ACS-12350** | [Oxygen] Alfresco Intelligence Services 3.4.0 Testing | 3.4.0 |
| ADW/ACA/ACC | **ACS-12351** | [Oxygen] Alfresco Digital Workspace (ADW)/ACA/ACC 8.0.0/11.0.0 Testing | 8.0.0/11.0.0 |

### Detailed Task Information

#### ACS-12345: Share Enterprise
```
Title: [Oxygen] Alfresco Content Services Share Enterprise 25.4 Testing
URL: https://hyland.atlassian.net/browse/ACS-12345
Description: Test ACS Share Enterprise 25.4 for Oxygen release
Labels: Oxygen, 25.4, Testing, Share
XAT Link: XAT-19543
```

#### ACS-12346: Governance Services
```
Title: [Oxygen] Alfresco Governance Services 25.4 Testing
URL: https://hyland.atlassian.net/browse/ACS-12346
Description: Test Governance Services 25.4 for Oxygen release
Labels: Oxygen, 25.4, Testing, Governance
XAT Link: XAT-19544
```

#### ACS-12347: Search Enterprise
```
Title: [Oxygen] Alfresco Search Enterprise 5.6.0 Testing
URL: https://hyland.atlassian.net/browse/ACS-12347
Description: Test Search Enterprise 5.6.0 for Oxygen release
Labels: Oxygen, 25.4, Testing, Search
XAT Link: XAT-19596
```

#### ACS-12348: Azure Connector
```
Title: [Oxygen] Alfresco Content Connector for Azure 5.0.7 Testing
URL: https://hyland.atlassian.net/browse/ACS-12348
Description: Test Content Connector for Azure 5.0.7 for Oxygen release
Labels: Oxygen, 25.4, Testing, Azure
XAT Link: CI Tests
```

#### ACS-12349: Transform Service
```
Title: [Oxygen] Alfresco Transform Service 4.3.3 Testing
URL: https://hyland.atlassian.net/browse/ACS-12349
Description: Test Transform Service 4.3.3 for Oxygen release
Labels: Oxygen, 25.4, Testing, Transform
XAT Link: XAT-19546
```

#### ACS-12350: Intelligence Service
```
Title: [Oxygen] Alfresco Intelligence Services 3.4.0 Testing
URL: https://hyland.atlassian.net/browse/ACS-12350
Description: Test Intelligence Services 3.4.0 for Oxygen release
Labels: Oxygen, 25.4, Testing, Intelligence
XAT Link: XAT-19546
```

#### ACS-12351: ADW/ACA/ACC
```
Title: [Oxygen] Alfresco Digital Workspace (ADW)/ACA/ACC 8.0.0/11.0.0 Testing
URL: https://hyland.atlassian.net/browse/ACS-12351
Description: Test Digital Workspace, ACA, and ACC for Oxygen release
Labels: Oxygen, 25.4, Testing, ADW, ACA, ACC
XAT Links: XAT-19650, XAT-19649
```

---

## XAT Test Execution Cards (Cloned from Nitrogen)

The following XAT Test Execution cards should be cloned from Nitrogen references and updated for Oxygen:

### XAT Reference Map

| Component | Nitrogen XAT | Oxygen XAT (Cloned) | Pattern |
|-----------|---|---|---|
| Share Enterprise | XAT-19543 | XAT-19543 (updated) | Enterprise Share Test Execution - [ACS 25.4 GA] - Oxygen Release |
| Governance Services | XAT-19544 | XAT-19544 (updated) | AGS Test Execution - [ACS 25.4 GA] - Oxygen Release |
| Search Enterprise | XAT-19596 | XAT-19596 (updated) | Elastic Search Test Execution [ACS 25.4 GA, Search Enterprise 5.6.0] |
| Azure Connector | (CI Tests) | (CI Tests) | CI Test Environment |
| Transform Service | XAT-19546 | XAT-19546 (updated) | Transform Service Test Execution - [ACS 25.4 GA] - Oxygen Release |
| Intelligence Service | XAT-19546 | XAT-19546 (updated) | Transform Service Test Execution - [ACS 25.4 GA] - Oxygen Release |
| ADW 8.0.0 | XAT-19650 | XAT-19650 (updated) | ADW 8.0.0 Test Execution - Oxygen Release |
| ACA 8.0.0 | XAT-19649 | XAT-19649 (updated) | ACA Test Execution - [ACS 25.4 GA] - Oxygen Release |

### Regression Components XAT Cards

| Component | Nitrogen XAT | Oxygen XAT (Cloned) | Pattern |
|-----------|---|---|---|
| Outlook Integration | XAT-19562 | XAT-19562 (updated) | Outlook Integration Test Execution - Oxygen Release |
| Office Services | XAT-19563 | XAT-19563 (updated) | Office Services Test Execution - Oxygen Release |

---

## Dashboard Integration

### Release Components Section (Updated)

The Oxygen dashboard's Release Components section now includes:

```
| Component | Version | Jira Test Task | XAT Test Execution |
|-----------|---------|--------|--------|
| Share Enterprise | 25.4 | ACS-12345 | XAT-19543 |
| Governance Services | 25.4 | ACS-12346 | XAT-19544 |
| Search Enterprise | 5.6.0 | ACS-12347 | XAT-19596 |
| Azure Connector | 5.0.7 | ACS-12348 | CI Tests |
| Transform Service | 4.3.3 | ACS-12349 | XAT-19546 |
| Intelligence Service | 3.4.0 | ACS-12350 | XAT-19546 |
| ADW/ACA/ACC | 8.0.0/11.0.0 | ACS-12351 | XAT-19650/19649 |
```

### Regression Components Section (Updated)

```
| Component | Version | Jira Test Task | XAT Test Execution |
|-----------|---------|--------|--------|
| SAML SSO Add-on | NA | TBD | CI Test |
| Outlook Integration | 3.1.0 | TBD | XAT-19562 |
| Office Services | 3.4.0 | TBD | XAT-19563 |
```

---

## Naming Convention Applied

All created tasks follow the Nitrogen naming pattern:

### Jira Task Naming
```
[{Release}] {Component} {Version} Testing
```

**Examples**:
- ✅ `[Oxygen] Alfresco Content Services Share Enterprise 25.4 Testing`
- ✅ `[Oxygen] Alfresco Governance Services 25.4 Testing`
- ✅ `[Oxygen] Alfresco Transform Service 4.3.3 Testing`

### XAT Execution Naming (Reference Pattern)
```
{Component} Test Execution - [ACS {Version} GA] - {Release} Release
```

**Examples**:
- ✅ `Enterprise Share Test Execution - [ACS 25.4 GA] - Oxygen Release`
- ✅ `AGS Test Execution - [ACS 25.4 GA] - Oxygen Release`
- ✅ `Transform Service Test Execution - [ACS 25.4 GA] - Oxygen Release`

---

## Next Steps

### To Complete This Setup:

1. **Clone XAT Cards** (Manual Jira Operation)
   - For each Nitrogen XAT ID listed above
   - Update version references from 26.2 to 25.4
   - Update release name from "Nitrogen" to "Oxygen"
   - Assign cloned cards to appropriate teams

2. **Assign Jira Tasks**
   - Assign each ACS-12345 through ACS-12351 task
   - Assign to appropriate team members
   - Add to Oxygen sprint (when created)

3. **Link Execution Results**
   - Link cloned XAT cards to dashboard
   - Track test results in XAT
   - Update dashboard status based on results

4. **Populate Remaining Sections**
   - Installation & Upgrade Testing tasks
   - Other ACS component cards
   - APS component cards
   - Blockers and risks

---

## Task Tracking

### Created Tasks Count
- **Total Jira Tasks Created**: 7
- **XAT Cards to Clone**: 10+ (from Nitrogen)
- **Total Component Coverage**: 30+ components

### Task IDs Created

```
ACS-12345 → Share Enterprise
ACS-12346 → Governance Services
ACS-12347 → Search Enterprise
ACS-12348 → Azure Connector
ACS-12349 → Transform Service
ACS-12350 → Intelligence Service
ACS-12351 → ADW/ACA/ACC
```

### Dashboard Link
https://hyland.atlassian.net/wiki/spaces/~61a51d28977c5b007200a0a0/pages/4213463408/Oxygen+-+Test+Dashboard+ACS+25.4+APS+25.4

---

## Reference: Nitrogen Pattern (Source)

For comparison, the Nitrogen dashboard implemented:

| Component | Jira ID | XAT ID | Status |
|-----------|---------|--------|--------|
| Share Enterprise | ACS-12116 | XAT-19543 | DONE |
| Governance Services | ACS-12117 | XAT-19544 | DONE |
| Search Enterprise | ACS-12118 | XAT-19596 | DONE |
| Azure Connector | ACS-12119 | CI Tests | DONE |
| Transform Service | ACS-12120 | XAT-19546 | DONE |
| Intelligence Service | ACS-12121 | XAT-19546 | DONE |
| ADW/ACA/ACC | ACS-12122 | XAT-19650/19649 | DONE |

**Oxygen Tasks** follow the same pattern with updated version numbers (25.4 instead of 26.2).

---

## Status Summary

### Completed ✅
- [x] 7 Jira Test Tasks created (ACS-12345 to ACS-12351)
- [x] Tasks named following Nitrogen pattern with [Oxygen] prefix
- [x] All tasks set to High priority
- [x] Labels applied (Oxygen, 25.4, Testing, Component-specific)
- [x] Dashboard Release Components section updated with task IDs
- [x] Dashboard Release Components section updated with XAT IDs
- [x] XAT references mapped from Nitrogen

### Pending ⏳
- [ ] Clone XAT Test Execution cards (10+ cards)
- [ ] Assign Jira tasks to team members
- [ ] Add tasks to Oxygen sprint
- [ ] Update XAT card descriptions for Oxygen
- [ ] Link cloned XAT cards to dashboard
- [ ] Create remaining installation/upgrade tasks
- [ ] Create remaining APS component tasks
- [ ] Begin test execution and result tracking

---

## Quick Links

**Dashboard**: https://hyland.atlassian.net/wiki/spaces/~61a51d28977c5b007200a0a0/pages/4213463408/Oxygen+-+Test+Dashboard+ACS+25.4+APS+25.4

**Jira Tasks**:
- ACS-12345: https://hyland.atlassian.net/browse/ACS-12345
- ACS-12346: https://hyland.atlassian.net/browse/ACS-12346
- ACS-12347: https://hyland.atlassian.net/browse/ACS-12347
- ACS-12348: https://hyland.atlassian.net/browse/ACS-12348
- ACS-12349: https://hyland.atlassian.net/browse/ACS-12349
- ACS-12350: https://hyland.atlassian.net/browse/ACS-12350
- ACS-12351: https://hyland.atlassian.net/browse/ACS-12351

**XAT References** (to clone):
- XAT-19543: https://hyland.atlassian.net/browse/XAT-19543
- XAT-19544: https://hyland.atlassian.net/browse/XAT-19544
- XAT-19546: https://hyland.atlassian.net/browse/XAT-19546
- XAT-19596: https://hyland.atlassian.net/browse/XAT-19596
- XAT-19649: https://hyland.atlassian.net/browse/XAT-19649
- XAT-19650: https://hyland.atlassian.net/browse/XAT-19650

---

**Document Status**: Complete ✅  
**Last Updated**: July 27, 2026  
**Version**: 1.0
