# Oxygen Dashboard Correction Plan

**Status**: Ready for Execution  
**Date**: July 27, 2026

---

## Current Issues Identified

### Issue 1: Incomplete Release Components Table
- **Current**: Only 7 components (ACS-12345 through ACS-12351)
- **Should be**: 25-30 components like Nitrogen
- **Missing**: 18-23 components

### Issue 2: Wrong XAT References
- **Current**: Copy-pasted Nitrogen XAT IDs (XAT-19543, XAT-19544, etc.)
- **Should be**: Cloned XAT tasks with NEW Oxygen-specific IDs
- **Problem**: Using same XAT IDs means tests execute on same task records instead of new Oxygen-specific ones

### Issue 3: Regression Components
- **Current**: Correct (SAML SSO, Outlook, Office Services)
- **Action**: Keep as-is (no changes needed)

---

## Correct Structure for Oxygen Dashboard

### Release Components (25-30 components being released in Oxygen 25.4)

**Core ACS Components**:
1. Alfresco Content Services Share Enterprise (25.4) → ACS-12345
2. Alfresco Governance Services (25.4) → ACS-12346
3. Alfresco Search Enterprise (5.6.0) → ACS-12347
4. Alfresco Content Connector for Azure (5.0.7) → ACS-12348
5. Alfresco Transform Service (4.3.3) → ACS-12349
6. Alfresco Intelligence Service (3.4.0) → ACS-12350
7. Alfresco Digital Workspace (ADW) (8.0.0) → NEW TASK
8. ACA (8.0.0) → NEW TASK
9. Alfresco Development Framework (8.8.0) → NEW TASK
10. Alfresco Control Center (ACC) (11.0.0) → NEW TASK
11. Alfresco Search & Insight Engine (2.0.21) → NEW TASK
12. Alfresco Out-of-Process SDK (7.3.3) → NEW TASK
13. Alfresco Out-of-Process Audit (1.3.3) → NEW TASK
14. Alfresco Content Connector for AWS S3 (7.0.4) → NEW TASK
15. api-explorer (25.4) → NEW TASK
16. Alfresco Collaboration Connector for Teams (2.1.3) → NEW TASK
17. Alfresco Collaboration Connector for Microsoft 365 (2.1.3) → NEW TASK
18. Alfresco Content Connector for SAP Applications (7.1.0) → NEW TASK
19. Alfresco Content Connector for SAP Cloud (7.1.0) → NEW TASK
20. Alfresco Sync Service (5.3.5) → NEW TASK
21. Alfresco Desktop Sync (1.25) → NEW TASK
22. Alfresco Extension Inspector (2.7.0) → NEW TASK
23. Alfresco Federation Services (5.3.0) → NEW TASK
24. Alfresco Enterprise Viewer (4.5.1) → NEW TASK
25. Alfresco Content Accelerator (4.5.1) → NEW TASK
26. Alfresco Content Connector for SAP ILM (1.0.3) → NEW TASK
27. Alfresco Content Connector for Salesforce (4.1.0) → NEW TASK
28. Alfresco Google Docs Integration (4.1.1) → NEW TASK
29. Alfresco CIC Connector (1.0) → NEW TASK
30. Alfresco CIC SDK (1.0) → NEW TASK
31. Hyland Drive for Alfresco (1.0) → NEW TASK

### Regression Components (Stable across releases - NO CHANGES)

1. SAML SSO Add-on (NA) → TBD
2. Alfresco Outlook Integration Client (3.1.0) → TBD
3. Alfresco Office Services (3.4.0) → TBD

---

## Execution Steps

### Phase 1: Create All Jira Test Tasks (31 total)
- 7 tasks already created (ACS-12345 through ACS-12351)
- Need to create 24 more tasks for remaining components
- Follow pattern: `[Oxygen] {Component} {Version} Testing`
- All Priority: High
- All Labels: Oxygen, 25.4, Testing, {Component-specific}

### Phase 2: Clone XAT Test Execution Tasks
- For each Nitrogen XAT card (from Nitrogen Release Components section)
- Clone each task (creates new XAT ID for Oxygen)
- Update clone summary: Change "Nitrogen" to "Oxygen", 26.2 to 25.4
- Assign cloned XAT to appropriate team

### Phase 3: Update Oxygen Dashboard
- Add all 31 Release Components rows with:
  - Component name
  - Version number (Oxygen version)
  - Jira Test Task ID (newly created ACS-XXXXX)
  - XAT Test Execution ID (newly cloned XAT-XXXXX)
- Keep Regression Components section as-is (no XAT cloning needed for regression)

### Phase 4: Verify & Publish
- Verify all Jira IDs are linked and functional
- Verify all XAT IDs are cloned (not copied)
- Confirm dashboard structure matches Nitrogen pattern
- Mark complete

---

## Version Mapping (Oxygen 25.4 vs Nitrogen 26.2)

| Component | Nitrogen 26.2 | Oxygen 25.4 | Change |
|-----------|---|---|---|
| Share Enterprise | 26.2 | 25.4 | Version update |
| Governance Services | 26.2 | 25.4 | Version update |
| Search Enterprise | 5.7.0 | 5.6.0 | Downgrade |
| Transform Service | 4.4.3 | 4.3.3 | Downgrade |
| Intelligence Service | 3.4.4 | 3.4.0 | Downgrade |
| ADW | 8.0.0 | 8.0.0 | Same |
| ACA | 8.0.0 | 8.0.0 | Same |
| ACC | 11.0.0 | 11.0.0 | Same |
| ... | (others same) | (others same) | Same versions |

---

## XAT Cloning Strategy

### For Release Components:
**Clone each Nitrogen XAT and update for Oxygen**

Example:
```
Original (Nitrogen): XAT-19543 - Enterprise Share Test Execution - [ACS 26.2 GA] - Nitrogen Release
Clone for Oxygen: XAT-XXXXX - Enterprise Share Test Execution - [ACS 25.4 GA] - Oxygen Release
```

This ensures:
- ✅ Separate test execution records for Oxygen
- ✅ Test results don't mix with Nitrogen
- ✅ Each release has independent test tracking

### For Regression Components:
**Keep existing XAT IDs (no cloning needed)**
- These test stable functionality
- Can reference existing Nitrogen XAT cards
- Or create new ones for isolation

---

## Expected Outcome

### Before Fix ❌
- Release Components: 7 rows (incomplete)
- XAT References: Copy-pasted (wrong IDs)
- Regression Components: Correct (3 rows)
- Total Components: 10

### After Fix ✅
- Release Components: 31 rows (complete)
- XAT References: Cloned (new IDs per release)
- Regression Components: Correct (3 rows)
- Total Components: 34
- Structure: Matches Nitrogen pattern
- Isolation: Oxygen tests separate from Nitrogen

---

## Next Actions

1. **Create 24 additional Jira tasks** (already have 7)
2. **Clone all Nitrogen XAT cards** to create Oxygen-specific XAT IDs
3. **Update Release Components table** with all 31 components
4. **Verify Regression Components** (keep as-is)
5. **Update dashboard** with new Jira and XAT IDs
6. **Mark complete** when all verified

---

**Ready to Execute**: Yes ✅
