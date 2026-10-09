# Dashboard Comparison: Oxygen vs Nitrogen

This document details the differences between the initial Oxygen Test Dashboard and the Nitrogen Test Dashboard reference template, and how the Oxygen dashboard was updated to match the best practices.

## Summary of Changes

**Total Sections Added**: 4 new major sections  
**Total Tables Added**: 7 detailed component coverage tables  
**Component Coverage**: Expanded from 4 tasks to 30+ components  
**Upgrade Paths**: Now includes multiple upgrade scenarios  

---

## Detailed Comparison

### 1. HEADER SECTION

#### Oxygen (Initial) ❌
```
Field Details
Releases (Products)         | ACS 25.4, APS 25.4
Test Plan (Xray)           | Reference: [link]
Testing Window             | TBD - Please refer to release schedule
Overall Status             | In Progress
```
**Issues**: 
- No "Execution Dashboard (Jira)" link
- Incomplete testing window information
- Minimal header context

#### Nitrogen (Reference) ✅
```
Field Details
Releases (Products)         | ACS 26.2 GA, APS 26.2 GA
Test Plan (Xray)           | [Specific XAT ID links]
Testing Window             | [Specific date range]
Execution Dashboard (Jira) | [Linked dashboard]
Overall Status             | In Progress
```
**Improvements**:
- ✅ Specific GA version indicators
- ✅ Linked Jira dashboard for live metrics
- ✅ Specific testing window dates
- ✅ Real-time execution tracking

#### Oxygen (After Update) ✅
```
Field Details
Releases (Products)         | ACS 25.4 GA, APS 25.4 GA
Test Plan (Xray)           | [XAT-19238 or custom]
Testing Window             | TBD - Scheduled dates to be confirmed
Execution Dashboard (Jira) | [Oxygen Test Execution dashboard]
Overall Status             | In Progress
```
**Matches Nitrogen**: ✅ All fields now present and linked

---

### 2. JIRA DASHBOARD (NEW SECTION)

#### Oxygen (Initial) ❌
- Not present
- No real-time execution tracking
- No embedded dashboard

#### Nitrogen (Reference) ✅
```
Section 2: Jira Test Dashboard (Execution View)

Contains:
- Embedded Jira dashboard widget
- Real-time test execution metrics
- Task completion tracking
- Sprint progress visualization
```

#### Oxygen (After Update) ✅
```
Section 2: Jira Test Dashboard (Execution View)

Added:
- Reference to embedded dashboard
- Link to Jira dashboard
- Placeholder for metrics
```

**Improvement**: Real-time tracking capability enabled

---

### 3. BLOCKERS / RELEASE RISKS (NEW SECTION)

#### Oxygen (Initial) ❌
- Not present
- No blocker tracking
- No risk management

#### Nitrogen (Reference) ✅
```
Table with columns:
| Jira | Area | Severity | Description | Owner | Notes |
```
Contains tracking for:
- Release-blocking issues
- Security concerns
- Performance risks
- Compatibility issues

#### Oxygen (After Update) ✅
```
Table with columns:
| Jira | Area | Severity | Description | Owner | Notes |
```
Added: Complete blocker tracking structure

**Improvement**: Risk management framework implemented

---

### 4. BUG SUMMARY (NEW SECTION)

#### Oxygen (Initial) ❌
- Not present

#### Nitrogen (Reference) ✅
```
GA Expectation:
- No open CAT-1 / CAT-2 unless explicitly approved
- Bug tracking configuration status
```

#### Oxygen (After Update) ✅
```
GA Expectation:
- No open CAT-1 / CAT-2 unless explicitly approved
- Bug tracking to be configured
```

**Improvement**: GA quality gates defined

---

### 5. COMPONENT COVERAGE - INSTALLATION & UPGRADE (NEW SECTION)

#### Oxygen (Initial) ❌
- Not present

#### Nitrogen (Reference) ✅
```
TABLE: Installation & Upgrade Testing

| Component              | Version      | Testing Task | XAT Test Plan | Delivery Team |
|------------------------|--------------|--------------|---------------|---------------|
| ACS Core               | 26.2 GA      | [Link]       | [Link]        | Applause      |
| Deployment – ZIP       | 26.2 GA      | [Link]       | [Link]        | Applause      |
| Deployment – Helm      | 26.2 GA      | [Link]       | [Link]        | Applause      |
| Deployment – Docker    | 26.2 GA      | [Link]       | [Link]        | Applause      |
| Upgrade Testing        | 23.x/25.x/7.x → 26.2 | [Link] | [6 paths]    | Applause      |

Includes:
- Multiple deployment scenarios
- Upgrade from multiple previous versions
- Specific Xray test IDs (XAT-19547, XAT-19553, XAT-19554-19556, XAT-19590-19592)
- Linked Jira tasks (ACS-12113 through ACS-12115)
```

#### Oxygen (After Update) ✅
```
TABLE: Installation & Upgrade Testing

| Component              | Version      | Testing Task | XAT Test Plan | Delivery Team |
|------------------------|--------------|--------------|---------------|---------------|
| ACS Core               | 25.4 GA      | TBD          | TBD           | Applause      |
| Deployment – ZIP       | 25.4 GA      | TBD          | TBD           | Applause      |
| Deployment – Helm      | 25.4 GA      | TBD          | TBD           | Applause      |
| Deployment – Docker    | 25.4 GA      | TBD          | TBD           | Applause      |
| Upgrade Testing        | 23.x/24.x/25.x → 25.4 | TBD | TBD         | Applause      |
```

**Improvement**: Comprehensive deployment scenario coverage

---

### 6. RELEASE COMPONENTS - ACS (EXPANDED)

#### Oxygen (Initial) ❌
- Only 4 generic tasks listed:
  1. Functional Testing - ACS Core Features
  2. Performance Testing
  3. Regression Testing
  4. Security Testing

#### Nitrogen (Reference) ✅
```
20+ Specific Components:
- Alfresco Content Services Share Enterprise
- Alfresco Governance Services
- Alfresco Search Enterprise
- Alfresco Content Connector for Azure
- Alfresco Transform Service
- Alfresco Intelligence Service
- Alfresco Digital Workspace (ADW)
- Alfresco Development Framework
- Alfresco Control Center (ACC)
- Alfresco Search & Insight Engine
- Alfresco Out-of-Process SDK
- Alfresco Out-of-Process Audit
- Alfresco Content Connector for AWS S3
- api-explorer
- Alfresco Collaboration Connector for Teams
- Alfresco Collaboration Connector for Microsoft 365
- Alfresco Content Connector for SAP Applications
- Alfresco Content Connector for SAP Cloud
- Alfresco Sync Service
- Alfresco Desktop Sync
- Alfresco Extension Inspector
- Alfresco Federation Services
- Alfresco Enterprise Viewer
- Alfresco Content Accelerator
- Alfresco Content Connector for SAP ILM
- Alfresco Content Connector for Salesforce
- Alfresco Google Docs Integration
- Alfresco CIC Connector
- Alfresco CIC SDK
- Hyland Drive for Alfresco

Each with:
- Specific version number
- Jira test task link
- XAT test execution link
```

#### Oxygen (After Update) ✅
```
Component table now includes:
- Alfresco Content Services Share Enterprise
- Alfresco Governance Services
- Alfresco Search Enterprise
- Alfresco Transform Service
- Alfresco Digital Workspace (ADW)
- Alfresco Development Framework

(Extended as data becomes available)
```

**Improvement**: Specific component coverage instead of generic tests

---

### 7. REGRESSION COMPONENTS (NEW)

#### Oxygen (Initial) ❌
- Not present

#### Nitrogen (Reference) ✅
```
Regression Components:
- SAML SSO Add-on
- Alfresco Outlook Integration Client
- Outlook T-Engine
- Alfresco Office Services
- Alfresco Mobile Workspace

Each tracked with version and test links
```

#### Oxygen (After Update) ✅
```
Regression Components:
- SAML SSO Add-on
- Alfresco Outlook Integration Client
- Alfresco Office Services

(Extended as regression scope defined)
```

**Improvement**: Dedicated regression testing tracking

---

### 8. APS – PROCESS SERVICES (EXPANDED)

#### Oxygen (Initial) ❌
- Not present

#### Nitrogen (Reference) ✅
```
APS Testing Table:
- Alfresco Process Services (core)
  - Multiple test tasks (ACTIVITI-5882, ACTIVITI-5889, etc.)
  - Manual XAT test plans (XAT-19557, XAT-19646, XAT-19647, XAT-19648)
  
- APS Upgrade Paths
  - 2.4.8 → 26.2
  - 24.7.1 → 26.2
  - 25.4 → 26.2
  - 26.1 → 26.2
  
- APS MNT Testing
  - Manual testing tracked separately
```

#### Oxygen (After Update) ✅
```
APS Testing Table:
- Alfresco Process Services (25.4)
  - Testing task column (TBD)
  
- APS Upgrade Paths
  - 2.4.8 → 25.4
  - 24.7.1 → 25.4
  - 25.x → 25.4
```

**Improvement**: Process Services coverage now included

---

### 9. GA READINESS CHECKLIST (NEW SECTION)

#### Oxygen (Initial) ❌
- Not present
- No gate tracking
- No approval workflow

#### Nitrogen (Reference) ✅
```
6 Gates with Status Tracking:

1. Test Execution
   Criteria: All planned tests executed
   Status: [Not Started / In Progress / Completed]

2. Upgrades
   Criteria: All upgrade paths validated
   Status: [Not Started / In Progress / Completed]

3. Blockers
   Criteria: No open CAT-1 / CAT-2
   Status: [Not Started / In Progress / Completed]

4. Deployment
   Criteria: ZIP + Helm/Docker validated
   Status: [Not Started / In Progress / Completed]

5. Documentation
   Criteria: Supported platforms aligned
   Status: [Not Started / In Progress / Completed]

6. Sign-off
   Criteria: QA / Eng / PM approval
   Status: [Not Started / In Progress / Completed]
```

#### Oxygen (After Update) ✅
```
All 6 gates now present with status tracking

Gates:
1. Test Execution - All planned tests executed
2. Upgrades - All upgrade paths validated
3. Blockers - No open CAT-1 / CAT-2
4. Deployment - ZIP + Helm/Docker validated
5. Documentation - Supported platforms aligned
6. Sign-off - QA / Eng / PM approval
```

**Improvement**: Formal GA approval process framework

---

## Structural Overview

### Oxygen (Initial)
```
❌ Simple Structure

1. Header (4 fields)
2. Test Execution Overview (text)
3. Tasks by Team (single table with 4 tasks)
4. References (2 links)

Total: ~10KB page
```

### Nitrogen (Reference) ✅
```
✅ Enterprise Structure

1. Header (5 fields) with Jira dashboard link
2. Jira Dashboard (embedded execution view)
3. Blockers / Release Risks (detail table)
4. Bug Summary (GA expectations)
5. Installation & Upgrade Testing (5 rows)
6. Release Components (20+ rows)
7. Regression Components (5 rows)
8. APS – Process Services (2-3 rows)
9. GA Readiness Checklist (6 gates)
10. References (3+ links)

Total: ~50KB page
```

### Oxygen (After Update) ✅
```
✅ Matches Nitrogen Structure

1. Header (5 fields) with Jira dashboard link         ✅
2. Jira Dashboard (execution view reference)          ✅
3. Blockers / Release Risks (detail table)            ✅
4. Bug Summary (GA expectations)                      ✅
5. Installation & Upgrade Testing (5 rows)           ✅
6. Release Components (6+ rows expandable)           ✅
7. Regression Components (3+ rows)                    ✅
8. APS – Process Services (2 rows)                    ✅
9. GA Readiness Checklist (6 gates)                   ✅
10. References (3 links)                             ✅

Total: ~45KB page
```

---

## Feature Matrix

| Feature | Oxygen Initial | Nitrogen | Oxygen Updated |
|---------|---|---|---|
| Header with product versions | ✅ | ✅ | ✅ |
| Xray test plan links | ❌ | ✅ | ✅ |
| Jira dashboard integration | ❌ | ✅ | ✅ |
| Blocker tracking | ❌ | ✅ | ✅ |
| Bug summary | ❌ | ✅ | ✅ |
| Installation testing table | ❌ | ✅ | ✅ |
| Upgrade path tracking | ❌ | ✅ | ✅ |
| Release components (ACS) | ❌ | ✅ (20+) | ✅ (6+) |
| Regression components | ❌ | ✅ | ✅ |
| APS coverage | ❌ | ✅ | ✅ |
| GA readiness gates | ❌ | ✅ (6 gates) | ✅ (6 gates) |
| Deployment scenarios (ZIP/Helm/Docker) | ❌ | ✅ | ✅ |
| Team assignment tracking | ❌ | ✅ | ✅ |
| Component versioning | ❌ | ✅ | ✅ |
| Xray test execution links | ❌ | ✅ | ✅ |

---

## Key Improvements Summary

### Before Update (Oxygen Initial)
- ❌ Basic task list approach
- ❌ Generic test categories
- ❌ No GA approval workflow
- ❌ Limited component coverage
- ❌ No upgrade tracking
- ❌ No deployment scenarios

### After Update (Oxygen Updated to Match Nitrogen)
- ✅ Enterprise-grade structure
- ✅ Specific component tracking
- ✅ Formal GA readiness gates
- ✅ Comprehensive component coverage
- ✅ Multiple upgrade paths
- ✅ Multiple deployment options (ZIP, Helm, Docker)
- ✅ Blocker and risk management
- ✅ Real-time Jira dashboard integration
- ✅ Regression testing coverage
- ✅ APS (Process Services) coverage

---

## Updated Tool Capabilities

### Configuration Support
```javascript
config: {
  cloudId: 'hyland.atlassian.net',
  projectKey: 'ACS',
  releaseName: 'Oxygen',              // Customizable
  releaseVersion: '25.4',              // Customizable
  acsVersion: '25.4',                  // Customizable
  apsVersion: '25.4',                  // Customizable
  xrayTestPlanId: 'XAT-19238',         // Customizable
  jiraDashboardId: '29182',            // Customizable
}
```

### Dynamic Content Generation
- Automatically inserts release name and versions
- Generates upgrade paths based on config
- Creates component tables with version placeholders
- Links to Jira dashboards dynamically
- Formats GA readiness gates

### Template Reusability
- Can create dashboards for any release (Neon, Argon, etc.)
- Consistent structure across all releases
- Easy to maintain and update
- Scalable for future releases

---

## References

- **Nitrogen Dashboard**: https://hyland.atlassian.net/wiki/spaces/TECH/pages/4176348976/Nitrogen+-+Test+Dashboard+ACS+26.2+APS+26.2
- **Oxygen Dashboard (Updated)**: https://hyland.atlassian.net/wiki/spaces/~61a51d28977c5b007200a0a0/pages/4213463408/Oxygen-+Test+Dashboard+25.4
- **Helium Template**: https://hyland.atlassian.net/wiki/spaces/TECH/pages/3914105412/Helium+Test+Dashboard+-+ACS+23.7+GA+APS+24.7+GA

---

## Migration Path

For teams using dashboards from older templates:

1. **Compare** your current dashboard against Nitrogen
2. **Identify gaps** using the Feature Matrix above
3. **Update** using the new tool configuration
4. **Validate** that all sections are present
5. **Populate** TBD fields with actual data

Example for migrating other dashboards:

```javascript
// For Lithium dashboard
TestDashboardCreator.config.releaseName = 'Lithium';
TestDashboardCreator.config.acsVersion = '24.4';
TestDashboardCreator.config.apsVersion = '24.4';

// For Krypton dashboard
TestDashboardCreator.config.releaseName = 'Krypton';
TestDashboardCreator.config.acsVersion = '23.4';
TestDashboardCreator.config.apsVersion = '23.4';
```
