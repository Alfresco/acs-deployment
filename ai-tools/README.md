# Test Dashboard Creator Tool

Automated tool for creating comprehensive test dashboard pages in Confluence with Jira integration.

## Overview

This tool automates the creation of standardized test dashboard pages for Alfresco releases (Oxygen, Nitrogen, Helium, etc.). It creates structured Confluence pages with detailed component coverage, testing tasks, upgrade paths, and GA readiness checklists.

## Dashboard Structure

### Based on Nitrogen Template (Best Practice)

The tool is modeled after the **Nitrogen Test Dashboard (ACS 26.2, APS 26.2)** which represents the enterprise-grade dashboard structure:

```
1. Header Information
   - Releases (Products) - ACS and APS versions
   - Test Plan (Xray) - Link to test plans
   - Testing Window - Scheduled dates
   - Execution Dashboard (Jira) - Live dashboard link
   - Overall Status - Release progress indicator

2. Jira Test Dashboard (Execution View)
   - Embedded Jira dashboard for real-time metrics

3. Blockers / Release Risks / Open Security Issues
   - Table tracking blockers by Jira issue, area, severity, owner

4. Bug Summary
   - GA Expectation: No CAT-1/CAT-2 issues
   - Bug tracking configuration status

5. Component Coverage
   ├── Installation & Upgrade Testing
   │   ├── Alfresco Content Services (Core)
   │   ├── Deployment - ZIP
   │   ├── Deployment - Helm
   │   ├── Deployment - Docker
   │   └── Upgrade Testing (multiple paths)
   │
   ├── Release Components (ACS)
   │   ├── Alfresco Content Services Share Enterprise
   │   ├── Alfresco Governance Services
   │   ├── Alfresco Search Enterprise
   │   ├── Alfresco Transform Service
   │   ├── Alfresco Digital Workspace (ADW)
   │   └── More components (20+ total)
   │
   └── Regression Components
       ├── SAML SSO Add-on
       ├── Alfresco Outlook Integration Client
       └── Alfresco Office Services

6. APS – Process Services
   - Alfresco Process Services core
   - APS Upgrade Paths (multiple from older versions)
   - APS MNT Testing

7. GA Readiness Checklist
   ├── Test Execution - All planned tests executed
   ├── Upgrades - All upgrade paths validated
   ├── Blockers - No open CAT-1/CAT-2
   ├── Deployment - ZIP + Helm/Docker validated
   ├── Documentation - Supported platforms aligned
   └── Sign-off - QA / Eng / PM approval
```

## Key Features

### Standardized Components
- ✅ Header with product versions and test plans
- ✅ Execution dashboard integration
- ✅ Blockers and risks tracking
- ✅ Bug summary with GA expectations
- ✅ Installation & upgrade testing tasks
- ✅ Release component coverage (ACS)
- ✅ Regression component testing
- ✅ APS (Process Services) coverage
- ✅ GA readiness checklist with gates

### Jira Integration
- Creates test tasks with proper categorization
- Links tasks to components and versions
- Assigns delivery teams (Applause, etc.)
- Tracks test execution status
- Maps XAT test plans to tasks

### Configuration Support
- Customizable release names (Oxygen, Nitrogen, Neon, etc.)
- Version configuration (ACS and APS)
- Custom Xray test plan IDs
- Jira dashboard embedding
- Delivery team assignments

## Comparison: Oxygen vs Nitrogen

### Oxygen (Before Update)
- Basic 4-task structure
- Simple table layout
- No component breakdown
- No GA readiness checklist
- Limited coverage tracking

### Nitrogen (Reference Template)
- **Comprehensive component coverage** (30+ components)
- **Detailed upgrade paths** (multiple versions)
- **Installation & deployment options** (ZIP, Helm, Docker)
- **GA readiness gates** (6 approval criteria)
- **Regression testing** (SAML, Outlook, Office Services)
- **Blockers tracking** (Severity, owner, notes)
- **Jira dashboard integration** (embedded execution view)
- **APS-specific testing** (Upgrade paths, MNT testing)

### Oxygen (After Update)
✅ Now matches Nitrogen's comprehensive structure
✅ All sections from Nitrogen included
✅ Dynamic version configuration
✅ Ready for production use

## Usage

### Basic Usage

```javascript
const tool = require('./oxygen-test-dashboard-creator.js');

// Create Oxygen 25.4 dashboard (uses default config)
await tool.execute();
```

### Custom Release (Neon 26.0)

```javascript
const tool = require('./oxygen-test-dashboard-creator.js');

// Update configuration
tool.config.releaseName = 'Neon';
tool.config.acsVersion = '26.0';
tool.config.apsVersion = '26.0';
tool.config.xrayTestPlanId = 'XAT-19500';
tool.config.jiraDashboardId = '29183'; // Neon dashboard

// Create the dashboard
await tool.execute();
```

### Dry Run Preview

```javascript
const tool = require('./oxygen-test-dashboard-creator.js');

// Preview what will be created
const preview = await tool.dryRun();
console.log('Will create:', preview);
```

### Full Workflow with Validation

```javascript
const tool = require('./oxygen-test-dashboard-creator.js');

try {
  // Validate configuration
  await tool.validateConfig();
  
  // Preview
  const preview = await tool.dryRun();
  console.log('Preview:', preview);
  
  // Execute
  const result = await tool.execute();
  console.log('✅ Dashboard created:', result.pageUrl);
  console.log('📊 Jira tasks created:', result.tasksCreated.length);
} catch (error) {
  console.error('❌ Error:', error);
}
```

## Configuration Options

```javascript
{
  cloudId: 'hyland.atlassian.net',           // Atlassian Cloud ID
  projectKey: 'ACS',                         // Jira project for tasks
  releaseName: 'Oxygen',                     // Release name
  releaseVersion: '25.4',                    // Release version
  acsVersion: '25.4',                        // Alfresco Content Services version
  apsVersion: '25.4',                        // Alfresco Process Services version
  parentSpaceKey: '~61a51d28977c5b007200a0a0', // Confluence space
  templatePageId: '4176348976',              // Reference template (Nitrogen)
  xrayTestPlanId: 'XAT-19238',               // Xray test plan
  jiraDashboardId: '29182',                  // Jira dashboard ID
}
```

## Integration Points

### Required MCP Tools

The tool is designed to work with these MCP (Management Control Platform) tools:

1. **getConfluencePage**
   - Fetch template and reference pages
   - Extract existing dashboard structure

2. **createConfluencePage**
   - Create new test dashboard page
   - Generate comprehensive HTML content

3. **createJiraIssue**
   - Create installation test tasks
   - Create upgrade test tasks
   - Create deployment test tasks
   - Link to components and versions

4. **updateConfluencePage**
   - Add task links to dashboard
   - Update GA readiness status

### Implementation Status

- ✅ Configuration and structure design
- ✅ Page content generation template
- ✅ Jira task creation template
- ⏳ MCP tool integration (ready for activation)

## Dashboard Sections Reference

### Header (Section 1)
Fields: Releases, Test Plan, Testing Window, Execution Dashboard, Overall Status

### Jira Dashboard (Section 2)
Embedded live dashboard for real-time metrics

### Blockers (Section 3)
Columns: Jira, Area, Severity, Description, Owner, Notes

### Bug Summary (Section 4)
- GA Expectation text
- Bug tracking status

### Component Coverage (Section 5)
- Installation & Upgrade Testing table
- Release Components table (ACS)
- Regression Components table

### APS Services (Section 6)
- Core testing
- Upgrade paths
- MNT testing

### GA Readiness (Section 7)
- Test Execution gate
- Upgrades gate
- Blockers gate
- Deployment gate
- Documentation gate
- Sign-off gate

## Examples of Created Pages

### Nitrogen Test Dashboard
https://hyland.atlassian.net/wiki/spaces/TECH/pages/4176348976/Nitrogen+-+Test+Dashboard+ACS+26.2+APS+26.2

### Oxygen Test Dashboard (Updated)
https://hyland.atlassian.net/wiki/spaces/~61a51d28977c5b007200a0a0/pages/4213463408/Oxygen-+Test+Dashboard+25.4

### Template Reference
https://hyland.atlassian.net/wiki/spaces/TECH/pages/3914105412/Helium+Test+Dashboard+-+ACS+23.7+GA+APS+24.7+GA

## Future Enhancements

1. **Automation Improvements**
   - Auto-populate component versions from release data
   - Auto-generate upgrade paths based on support matrix
   - Parse blockers from existing Jira issues

2. **Team Integration**
   - Auto-assign tasks based on team configuration
   - Create sprint-specific dashboards
   - Auto-notify teams on task creation

3. **Metrics & Reporting**
   - Generate test execution reports
   - Track blocker resolution
   - Calculate GA readiness percentage

4. **Template Customization**
   - Support multiple dashboard layouts
   - Custom section configurations
   - Branding customization

## Troubleshooting

### Configuration Validation Errors
Ensure all required configuration fields are set:
```javascript
tool.config.cloudId          // Required
tool.config.projectKey       // Required
tool.config.releaseName      // Required
tool.config.acsVersion       // Required
tool.config.apsVersion       // Required
```

### Page Creation Failures
Check:
- Valid Confluence space key
- Atlassian Cloud ID correctness
- Required fields in page body

### Task Creation Issues
Verify:
- Jira project has required issue types
- User has permission to create issues
- Custom fields are properly configured

## Support & References

- **Nitrogen Dashboard**: Primary reference template
- **Oxygen Release Page**: https://hyland.atlassian.net/wiki/spaces/TECH/pages/4131029778/Releases+in+Oxygen
- **Atlassian Documentation**: https://www.atlassian.com/software/jira
- **Confluence Documentation**: https://www.atlassian.com/software/confluence

## License

Internal tool for Alfresco testing workflows.
