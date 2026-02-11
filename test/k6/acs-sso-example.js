import { browser } from 'k6/browser';
import { check, sleep } from 'k6';

// Get base URL from environment variable, default to localhost
const BASE_URL = __ENV.BASE_URL || 'http://localhost';

export const options = {
  scenarios: {
    ui: {
      executor: 'shared-iterations',
      options: {
        browser: {
          type: 'chromium',
        },
      },
    },
  },
  thresholds: {
    'checks{SSO:loginWithRedir}': ['rate==1'],
  },
};

export default async function () {
  const page = await browser.newPage();
  let shareSearchBox = null;
  let systemSummaryAdmin = null;
  let appName = null;
  let acaToolBar = null;
  try {
    await page.goto(`${BASE_URL}/share`);

    // Wait for the login page to load
    appName = await page.waitForSelector('input[name="username"]', { timeout: 15000 });

    // Enter login credentials
    await page.locator('input[name="username"]').type('admin');
    await page.locator('input[name="password"]').type('secret');
    await page.locator('input[type="submit"]').click();

    // Wait for the page to load the Quicksearch box
    shareSearchBox = await page.waitForSelector('#HEADER_SEARCHBOX_FORM_FIELD', { timeout: 15000 });

    await page.goto(`${BASE_URL}/alfresco/s/admin`);
    systemSummaryAdmin = await page.waitForSelector('a[title="Summary of general system information"]', { timeout: 3000 });

    await page.goto(`${BASE_URL}/aca`);
    acaToolBar = await page.waitForSelector('app-toolbar-menu', { timeout: 5000 });
  } finally {
    check(shareSearchBox, {
      'search box is visible': (el) => el !== null,
    }, {SSO: "loginWithRedir"});
    check(appName, {
      'identity service login form visible': (el) => el !== null,
    }, {SSO: "loginWithRedir"});
    check(systemSummaryAdmin, {
      'system summary admin is visible': (el) => el !== null,
    }, {SSO: "loginWithRedir"});
    check(acaToolBar, {
      'ACA toolbar is visible': (el) => el !== null,
    }, {SSO: "loginWithRedir"});
    await page.close();
  }
}
