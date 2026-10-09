"""
Generates PDF documentation explaining the OpenLDAP + Alfresco LDAP authentication/
synchronization setup used in docker-compose/26.N-compose-governance.yaml, so it can
be reproduced from scratch in future testing sessions.
"""
from reportlab.lib.pagesizes import LETTER
from reportlab.lib.units import inch
from reportlab.lib import colors
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.platypus import (
    SimpleDocTemplate, Paragraph, Spacer, Table, TableStyle, PageBreak,
    ListFlowable, ListItem, Preformatted
)
from reportlab.lib.enums import TA_CENTER

OUTPUT_PATH = r"C:\AlfrescoWork\acs-deployment\docker-compose\Alfresco_LDAP_Setup_Guide.pdf"

styles = getSampleStyleSheet()
styles.add(ParagraphStyle(name="TitleBig", fontSize=24, leading=28, spaceAfter=10, alignment=TA_CENTER, textColor=colors.HexColor("#1F2937")))
styles.add(ParagraphStyle(name="Subtitle", fontSize=13, leading=18, alignment=TA_CENTER, textColor=colors.HexColor("#4B5563"), spaceAfter=6))
styles.add(ParagraphStyle(name="SectionHeading", fontSize=16, leading=20, spaceBefore=18, spaceAfter=8, textColor=colors.HexColor("#111827")))
styles.add(ParagraphStyle(name="ServiceHeading", fontSize=13, leading=16, spaceBefore=14, spaceAfter=4, textColor=colors.white, backColor=colors.HexColor("#2563EB"), leftIndent=6, borderPadding=(4,4,4,4)))
styles.add(ParagraphStyle(name="SubHeading", fontSize=10.5, leading=13, spaceBefore=6, spaceAfter=2, textColor=colors.HexColor("#1D4ED8")))
styles.add(ParagraphStyle(name="Body", fontSize=10, leading=14, spaceAfter=4))
styles.add(ParagraphStyle(name="Mono", fontName="Courier", fontSize=8.3, leading=10.6, backColor=colors.HexColor("#F3F4F6"), leftIndent=6, spaceAfter=6, spaceBefore=2))
styles.add(ParagraphStyle(name="Small", fontSize=8.5, leading=11, textColor=colors.HexColor("#6B7280")))

doc = SimpleDocTemplate(
    OUTPUT_PATH, pagesize=LETTER,
    leftMargin=0.85*inch, rightMargin=0.85*inch,
    topMargin=0.8*inch, bottomMargin=0.8*inch,
    title="Alfresco LDAP Authentication & Synchronization Setup",
    author="Alfresco Deployment Documentation",
)

story = []

def mono_block(text):
    return Preformatted(text, styles["Mono"].clone('MonoPre', fontName="Courier", fontSize=8.0, leading=10.2,
                                                     backColor=colors.HexColor("#F3F4F6"), leftIndent=6,
                                                     spaceAfter=8, spaceBefore=2))

# ---------- Title page ----------
story.append(Spacer(1, 1.1*inch))
story.append(Paragraph("Alfresco LDAP Authentication &amp; Synchronization Setup", styles["TitleBig"]))
story.append(Paragraph("Reproducible OpenLDAP test environment for ACS via Docker Compose", styles["Subtitle"]))
story.append(Spacer(1, 0.3*inch))
story.append(Paragraph(
    "Based on: <font face='Courier'>docker-compose/26.N-compose-governance.yaml</font>, "
    "<font face='Courier'>docker-compose/ldap-custom-ldif/50-users.ldif</font>, "
    "<font face='Courier'>docker-compose/behaviour-derive-names-context.xml</font>, "
    "<font face='Courier'>docker-compose/derive-names-onCreateNode.js</font><br/>"
    "Location: C:\\AlfrescoWork\\acs-deployment\\docker-compose",
    styles["Small"]
))
story.append(Spacer(1, 2.0*inch))
story.append(Paragraph(
    "This guide documents, end-to-end, how an OpenLDAP directory server is stood up "
    "alongside an Alfresco Governance Services container, how Alfresco is configured to "
    "authenticate against and synchronize users/groups from it, how a custom LDIF file "
    "seeds edge-case test users, and how a small repository customization patches up "
    "users that are missing a first or last name. Follow the steps here to reproduce the "
    "whole environment from a clean checkout.",
    styles["Body"]
))
story.append(PageBreak())

# ---------- 1. Overview ----------
story.append(Paragraph("1. Overview &amp; Architecture", styles["SectionHeading"]))
story.append(Paragraph(
    "The LDAP test setup lives entirely inside one Docker Compose stack file, "
    "<font face='Courier'>26.N-compose-governance.yaml</font>. It adds a single new "
    "service &mdash; <b>openldap</b> &mdash; to the normal ACS/Governance stack, and wires "
    "the <b>alfresco</b> service's authentication chain to talk to it over plain LDAP "
    "(port 389, no TLS). The two containers communicate over the Compose-managed "
    "Docker network using the service name <font face='Courier'>openldap</font> as the "
    "hostname.",
    styles["Body"]
))

arch_rows = [
    ["Component", "Role"],
    ["openldap (osixia/openldap:1.5.0)", "LDAP directory server holding users/groups; seeded with test data on first boot"],
    ["alfresco (governance repository)", "Authenticates users and synchronizes cm:person/cm:authority nodes from LDAP"],
    ["50-users.ldif (custom bootstrap file)", "Pre-loads 3 test users covering missing first-name/last-name scenarios"],
    ["behaviour-derive-names-context.xml + derive-names-onCreateNode.js", "Repository-side fix-up: derives a blank firstName/lastName from the other, post-sync"],
]
t = Table(arch_rows, colWidths=[2.6*inch, 4.1*inch])
t.setStyle(TableStyle([
    ("BACKGROUND", (0,0), (-1,0), colors.HexColor("#2563EB")),
    ("TEXTCOLOR", (0,0), (-1,0), colors.white),
    ("FONTSIZE", (0,0), (-1,-1), 8.5),
    ("FONTNAME", (0,0), (-1,0), "Helvetica-Bold"),
    ("ROWBACKGROUNDS", (0,1), (-1,-1), [colors.white, colors.HexColor("#F3F4F6")]),
    ("GRID", (0,0), (-1,-1), 0.5, colors.HexColor("#D1D5DB")),
    ("VALIGN", (0,0), (-1,-1), "TOP"),
    ("TOPPADDING", (0,0), (-1,-1), 4),
    ("BOTTOMPADDING", (0,0), (-1,-1), 4),
]))
story.append(Spacer(1, 6))
story.append(t)
story.append(Spacer(1, 8))
story.append(Paragraph(
    "Alfresco's authentication chain is set to <font face='Courier'>ldap1:ldap,alfrescoNtlm:"
    "alfrescoNtlm</font> &mdash; meaning a login attempt is first tried against the LDAP "
    "subsystem (bind as the user against OpenLDAP); if that fails, it falls back to the "
    "repository's own (NTLM/DB-backed) authentication, so the built-in <b>admin</b> user "
    "still works even though it is not an LDAP entry.",
    styles["Body"]
))

# ---------- 2. OpenLDAP container ----------
story.append(Paragraph("2. The OpenLDAP Container", styles["SectionHeading"]))
story.append(Paragraph(
    "Defined as a new <font face='Courier'>openldap</font> service in the compose file, "
    "built from the public <font face='Courier'>osixia/openldap:1.5.0</font> image with one "
    "customization layered on top: the custom seed LDIF is copied into the image's "
    "bootstrap folder so it is loaded automatically the first time the container "
    "initializes its database.",
    styles["Body"]
))
story.append(mono_block(
"""openldap:
  build:
    context: .
    dockerfile_inline: |
      FROM osixia/openldap:1.5.0
      COPY ldap-custom-ldif/50-users.ldif /container/service/slapd/assets/config/bootstrap/ldif/custom/50-users.ldif
  mem_limit: 256m
  environment:
    LDAP_ORGANISATION: "Example Inc"
    LDAP_DOMAIN: "example.org"
    LDAP_BASE_DN: "dc=example,dc=org"
    LDAP_ADMIN_PASSWORD: "admin"
    LDAP_TLS: "false"
  ports:
    - "389:389"
  healthcheck:
    test: ["CMD", "ldapsearch", "-x", "-H", "ldap://localhost:389",
           "-D", "cn=admin,dc=example,dc=org", "-w", "admin",
           "-b", "dc=example,dc=org"]
    interval: 10s
    timeout: 5s
    retries: 5
    start_period: 15s"""
))
story.append(Paragraph("Key points", styles["SubHeading"]))
story.append(ListFlowable(
    [ListItem(Paragraph(s, styles["Body"])) for s in [
        "<b>Base DN</b> is <font face='Courier'>dc=example,dc=org</font> (derived from "
        "<font face='Courier'>LDAP_DOMAIN=example.org</font>).",
        "<b>Admin bind DN</b> is <font face='Courier'>cn=admin,dc=example,dc=org</font> with "
        "password <font face='Courier'>admin</font> &mdash; used by Alfresco's "
        "synchronization subsystem (it needs an account that can search/read the whole "
        "tree), not by end users.",
        "<b>Port 389</b> (plain LDAP, no TLS) is published to the host as well, so the "
        "directory can be queried directly from the host machine with tools like "
        "<font face='Courier'>ldapsearch</font> or Apache Directory Studio for "
        "troubleshooting.",
        "The <b>healthcheck</b> performs an authenticated search against the base DN; "
        "Alfresco's own <font face='Courier'>depends_on: openldap: condition: service_healthy</font> "
        "ensures the repository container doesn't start trying to synchronize before the "
        "directory is actually ready to answer queries.",
        "Custom bootstrap LDIFs placed under "
        "<font face='Courier'>/container/service/slapd/assets/config/bootstrap/ldif/custom/</font> "
        "are only applied the <b>first time</b> the container's data volume is initialized. "
        "If you change the LDIF and need it reloaded, you must remove the container's "
        "underlying volume/data first (see Troubleshooting).",
    ]],
    bulletType="bullet", leftIndent=16
))

story.append(PageBreak())

# ---------- 3. Seed LDIF ----------
story.append(Paragraph("3. Seed Data &mdash; 50-users.ldif", styles["SectionHeading"]))
story.append(Paragraph(
    "Location: <font face='Courier'>docker-compose/ldap-custom-ldif/50-users.ldif</font>. "
    "This file creates an organizational unit for users and three test accounts that "
    "deliberately exercise the \"missing name attribute\" edge cases that LDAP/Active "
    "Directory synchronization can run into in the real world.",
    styles["Body"]
))
story.append(mono_block(
"""dn: ou=users,dc=example,dc=org
objectClass: organizationalUnit
ou: users

# Scenario 1: ONLY FIRST NAME (givenName present, sn effectively blank)
dn: uid=jonly,ou=users,dc=example,dc=org
objectClass: inetOrgPerson
uid: jonly
cn: Jon
givenName: Jon
sn:: IA==                     # base64 for a single space character
mail: jonly@example.org
userPassword: password123

# Scenario 2: ONLY LAST NAME (sn present, no givenName attribute at all)
dn: uid=smithonly,ou=users,dc=example,dc=org
objectClass: inetOrgPerson
uid: smithonly
cn: Smith
sn: Smith
mail: smithonly@example.org
userPassword: password123

# Scenario 3: BOTH first and last name present
dn: uid=jdoe,ou=users,dc=example,dc=org
objectClass: inetOrgPerson
uid: jdoe
cn: Jane Doe
givenName: Jane
sn: Doe
mail: jdoe@example.org
userPassword: password123"""
))

test_user_rows = [
    ["Username", "givenName", "sn", "Purpose"],
    ["jonly", "Jon", "(single space)", "Simulates AD user with a blank Last Name field"],
    ["smithonly", "(absent)", "Smith", "Simulates user with no First Name attribute at all"],
    ["jdoe", "Jane", "Doe", "Normal/control case &mdash; both names present"],
]
t2 = Table(test_user_rows, colWidths=[1.1*inch, 1.0*inch, 1.3*inch, 3.3*inch])
t2.setStyle(TableStyle([
    ("BACKGROUND", (0,0), (-1,0), colors.HexColor("#2563EB")),
    ("TEXTCOLOR", (0,0), (-1,0), colors.white),
    ("FONTSIZE", (0,0), (-1,-1), 8.3),
    ("FONTNAME", (0,0), (-1,0), "Helvetica-Bold"),
    ("ROWBACKGROUNDS", (0,1), (-1,-1), [colors.white, colors.HexColor("#F3F4F6")]),
    ("GRID", (0,0), (-1,-1), 0.5, colors.HexColor("#D1D5DB")),
    ("VALIGN", (0,0), (-1,-1), "TOP"),
    ("TOPPADDING", (0,0), (-1,-1), 4),
    ("BOTTOMPADDING", (0,0), (-1,-1), 4),
]))
story.append(Spacer(1, 4))
story.append(t2)
story.append(Spacer(1, 6))
story.append(Paragraph(
    "All three users share the password <font face='Courier'>password123</font>. Note: "
    "<font face='Courier'>sn</font> (surname) is a <b>mandatory</b> attribute in the standard "
    "LDAP <font face='Courier'>person</font> schema that <font face='Courier'>inetOrgPerson</font> "
    "extends, so it can never be truly absent the way it can in Active Directory. To "
    "faithfully emulate an AD user whose admin left \"Last Name\" blank, the "
    "<font face='Courier'>jonly</font> entry sets <font face='Courier'>sn</font> to a single "
    "space character &mdash; encoded as base64 (<font face='Courier'>IA==</font>) because LDIF "
    "values that start with whitespace must be base64-encoded.",
    styles["Body"]
))

# ---------- 4. Alfresco config ----------
story.append(Paragraph("4. Alfresco Authentication &amp; Synchronization Config", styles["SectionHeading"]))
story.append(Paragraph(
    "All settings are passed to the <font face='Courier'>alfresco</font> container as "
    "<font face='Courier'>-D</font> system properties inside <font face='Courier'>JAVA_OPTS</font> "
    "(equivalent to setting them in <font face='Courier'>alfresco-global.properties</font>):",
    styles["Body"]
))
story.append(mono_block(
"""-Dauthentication.chain=ldap1:ldap,alfrescoNtlm:alfrescoNtlm

# --- Authentication (used at login time to bind as the user) ---
-Dldap.authentication.active=true
-Dldap.authentication.userNameFormat=uid=%s,ou=users,dc=example,dc=org
-Dldap.authentication.java.naming.factory.initial=com.sun.jndi.ldap.LdapCtxFactory
-Dldap.authentication.java.naming.provider.url=ldap://openldap:389
-Dldap.authentication.java.naming.security.authentication=simple

# --- Synchronization (scheduled job that imports users/groups) ---
-Dldap.synchronization.active=true
-Dldap.synchronization.java.naming.factory.initial=com.sun.jndi.ldap.LdapCtxFactory
-Dldap.synchronization.java.naming.provider.url=ldap://openldap:389
-Dldap.synchronization.java.naming.security.authentication=simple
-Dldap.synchronization.java.naming.security.principal=cn=admin,dc=example,dc=org
-Dldap.synchronization.java.naming.security.credentials=admin
-Dldap.synchronization.userSearchBase=ou=users,dc=example,dc=org
-Dldap.synchronization.groupSearchBase=dc=example,dc=org
-Dldap.synchronization.userIdAttributeName=uid
-Dldap.synchronization.userFirstNameAttributeName=givenName
-Dldap.synchronization.userLastNameAttributeName=sn
-Dldap.synchronization.userEmailAttributeName=mail
-Dldap.synchronization.defaultHomeFolderProvider=largeHomeFolderProvider
-Dldap.synchronization.groupIdAttributeName=cn
-Dldap.synchronization.groupType=groupOfNames
-Dldap.synchronization.personType=inetOrgPerson
-Dldap.synchronization.groupMemberAttributeName=member"""
))

story.append(Paragraph("Authentication vs. Synchronization", styles["SubHeading"]))
story.append(Paragraph(
    "These are two independent subsystems that happen to point at the same directory:",
    styles["Body"]
))
story.append(ListFlowable(
    [ListItem(Paragraph(s, styles["Body"])) for s in [
        "<b>ldap.authentication.*</b> runs at login time. Alfresco takes the username the "
        "user typed, substitutes it into "
        "<font face='Courier'>userNameFormat</font> (<font face='Courier'>uid=%s,ou=users,"
        "dc=example,dc=org</font>) to build a full DN, and attempts an LDAP <i>simple bind</i> "
        "with that DN and the password the user typed. Success = authenticated.",
        "<b>ldap.synchronization.*</b> runs as a background scheduled job (and on repository "
        "startup) using the admin service account "
        "(<font face='Courier'>cn=admin,dc=example,dc=org</font>) to search the whole "
        "directory and create/update corresponding <font face='Courier'>cm:person</font> "
        "(user) and <font face='Courier'>cm:authority</font> (group) nodes in the Alfresco "
        "repository, mapping LDAP attributes (<font face='Courier'>givenName</font>, "
        "<font face='Courier'>sn</font>, <font face='Courier'>mail</font>, ...) onto Alfresco "
        "person properties.",
        "A user can only successfully log in via LDAP <i>and</i> see a proper profile in "
        "Share if <b>both</b> are configured consistently against the same base DNs and "
        "attribute names.",
    ]],
    bulletType="bullet", leftIndent=16
))

story.append(PageBreak())

# ---------- 5. Derive-names fix-up ----------
story.append(Paragraph("5. Repository Customization: Deriving Missing Names", styles["SectionHeading"]))
story.append(Paragraph(
    "<font face='Courier'>cm:firstName</font> is declared mandatory in the Alfresco content "
    "model, but only as a <i>soft</i> (forms/UI) constraint &mdash; it is not "
    "<font face='Courier'>enforced=\"true\"</font>. LDAP synchronization writes nodes directly "
    "via <font face='Courier'>NodeService</font>, bypassing form validation entirely, so a "
    "user synced from a directory entry with a blank <font face='Courier'>givenName</font> or "
    "<font face='Courier'>sn</font> ends up with a genuinely empty name field in Share. There "
    "is no built-in <font face='Courier'>ldap.synchronization.*</font> property that supplies "
    "a fallback value for a missing attribute, so this environment adds a small custom "
    "behaviour to patch it up after the fact.",
    styles["Body"]
))
story.append(Paragraph("How it is packaged into the image", styles["SubHeading"]))
story.append(Paragraph(
    "The <font face='Courier'>alfresco</font> service's Dockerfile (inline, in the compose "
    "file) layers two files from the <font face='Courier'>docker-compose</font> folder on "
    "top of the base governance repository image:",
    styles["Body"]
))
story.append(mono_block(
"""FROM quay.io/alfresco/alfresco-governance-repository-enterprise:26.3.0-A.20
COPY behaviour-derive-names-context.xml \\
     /usr/local/tomcat/shared/classes/alfresco/extension/behaviour-derive-names-context.xml
COPY derive-names-onCreateNode.js \\
     /usr/local/tomcat/shared/classes/alfresco/extension/scripts/derive-names-onCreateNode.js"""
))
story.append(Paragraph(
    "Any <font face='Courier'>*-context.xml</font> file dropped into "
    "<font face='Courier'>shared/classes/alfresco/extension</font> is picked up automatically "
    "by Alfresco's Spring context scanning at startup &mdash; no WAR rebuild or module "
    "packaging (AMP/JAR) is required for this kind of simple extension.",
    styles["Body"]
))
story.append(Paragraph("behaviour-derive-names-context.xml", styles["SubHeading"]))
story.append(Paragraph(
    "Registers a JavaScript-backed policy behaviour on the <font face='Courier'>"
    "{http://www.alfresco.org/model/content/1.0}person</font> type, bound to the "
    "<font face='Courier'>onCreateNode</font> policy, pointing at the script below.",
    styles["Body"]
))
story.append(Paragraph("derive-names-onCreateNode.js", styles["SubHeading"]))
story.append(Paragraph(
    "Fires once, immediately after a new <font face='Courier'>cm:person</font> node is "
    "created (including by LDAP sync). Logic:",
    styles["Body"]
))
story.append(ListFlowable(
    [ListItem(Paragraph(s, styles["Body"])) for s in [
        "If <font face='Courier'>firstName</font> is blank/whitespace-only and "
        "<font face='Courier'>lastName</font> is populated &rarr; copy "
        "<font face='Courier'>lastName</font> into <font face='Courier'>firstName</font>.",
        "If <font face='Courier'>lastName</font> is blank and "
        "<font face='Courier'>firstName</font> is populated &rarr; copy it the other way.",
        "If <b>both</b> are blank &rarr; default both to the <font face='Courier'>userName</font>.",
        "Every change is written back with <font face='Courier'>person.save()</font> and "
        "logged, e.g. <font face='Courier'>[derive-names] jonly: blank lastName derived "
        "from firstName 'Jon'</font>.",
    ]],
    bulletType="bullet", leftIndent=16
))

# ---------- 6. Step-by-step reproduction ----------
story.append(PageBreak())
story.append(Paragraph("6. Step-by-Step: Running It Yourself", styles["SectionHeading"]))
story.append(ListFlowable(
    [ListItem(Paragraph(s, styles["Body"])) for s in [
        "Open a terminal (Git Bash, PowerShell, or WSL) and change into "
        "<font face='Courier'>C:\\AlfrescoWork\\acs-deployment\\docker-compose</font>.",
        "Make sure Docker Desktop is running and has at least ~13 GB of memory allocated "
        "(this stack includes the full Governance/Search/Transform set of services, not "
        "just LDAP).",
        "Start the stack in the background: "
        "<font face='Courier'>docker compose -f 26.N-compose-governance.yaml up -d</font>",
        "Watch the <font face='Courier'>openldap</font> container become healthy first "
        "(<font face='Courier'>docker compose -f 26.N-compose-governance.yaml ps</font>); "
        "the <font face='Courier'>alfresco</font> container will not start until it is, "
        "because of the <font face='Courier'>depends_on: openldap: condition: service_healthy"
        "</font> dependency.",
        "Tail the repository log until Tomcat/Alfresco finishes starting: "
        "<font face='Courier'>docker compose -f 26.N-compose-governance.yaml logs -f alfresco</font>",
        "Trigger (or wait for) the scheduled LDAP synchronization job so the seed users "
        "are imported as Alfresco persons/authorities. It also runs automatically a short "
        "time after the repository starts.",
        "Log in to Share (<font face='Courier'>http://localhost:8080/share</font>) as "
        "<font face='Courier'>jdoe</font> / <font face='Courier'>password123</font>, "
        "<font face='Courier'>jonly</font> / <font face='Courier'>password123</font>, or "
        "<font face='Courier'>smithonly</font> / <font face='Courier'>password123</font> to "
        "confirm LDAP authentication works end-to-end, and inspect each user's profile to "
        "confirm first/last name were derived correctly for the edge-case accounts.",
        "The built-in <font face='Courier'>admin</font> / <font face='Courier'>admin</font> "
        "account still works via the <font face='Courier'>alfrescoNtlm</font> fallback in "
        "the authentication chain, since it does not exist in LDAP.",
    ]],
    bulletType="1", start=1, leftIndent=16
))

story.append(Paragraph("Direct LDAP queries (bypassing Alfresco, useful for isolating problems)", styles["SubHeading"]))
story.append(mono_block(
"""# From the host (port 389 is published) or via "docker compose exec openldap ..."
ldapsearch -x -H ldap://localhost:389 \\
  -D "cn=admin,dc=example,dc=org" -w admin \\
  -b "dc=example,dc=org" "(uid=jdoe)"

# Test a simple bind as an end user (authentication path)
ldapwhoami -x -H ldap://localhost:389 \\
  -D "uid=jdoe,ou=users,dc=example,dc=org" -w password123"""
))

# ---------- 7. Customizing / adding users ----------
story.append(Paragraph("7. Adding or Changing Test Users", styles["SectionHeading"]))
story.append(ListFlowable(
    [ListItem(Paragraph(s, styles["Body"])) for s in [
        "Edit <font face='Courier'>docker-compose/ldap-custom-ldif/50-users.ldif</font> and "
        "add further <font face='Courier'>dn: uid=&lt;name&gt;,ou=users,dc=example,dc=org</font> "
        "entries following the same <font face='Courier'>inetOrgPerson</font> pattern.",
        "Bootstrap LDIFs under <font face='Courier'>osixia/openldap</font> are only applied "
        "on a <b>fresh</b> database. If the <font face='Courier'>openldap</font> container "
        "has already initialized once, either: (a) remove its container and any named "
        "volume so it reinitializes from the LDIF, or (b) add the new entries live with "
        "<font face='Courier'>ldapadd</font> against the running server using the admin "
        "credentials above.",
        "After adding users, either wait for the next scheduled LDAP synchronization run "
        "or trigger one manually from the Alfresco Admin Console "
        "(<font face='Courier'>/alfresco/s/enterprise/admin/admin-ldap</font> or the "
        "equivalent Synchronization page) so the new accounts appear as Alfresco persons.",
        "To add groups, create entries with <font face='Courier'>objectClass: groupOfNames</font> "
        "under the <font face='Courier'>groupSearchBase</font> "
        "(<font face='Courier'>dc=example,dc=org</font>), with a "
        "<font face='Courier'>cn</font> attribute (group id) and one or more "
        "<font face='Courier'>member</font> attributes holding member user DNs, matching "
        "<font face='Courier'>ldap.synchronization.groupType</font> / "
        "<font face='Courier'>groupMemberAttributeName</font>.",
    ]],
    bulletType="bullet", leftIndent=16
))

# ---------- 8. Troubleshooting ----------
story.append(Paragraph("8. Troubleshooting", styles["SectionHeading"]))
trouble_rows = [
    ["Symptom", "Likely cause / fix"],
    ["alfresco container never starts", "openldap healthcheck failing. Check "
     "`docker compose logs openldap`; confirm port 389 isn't already in use on the host."],
    ["LDIF changes don't appear", "osixia/openldap only applies bootstrap LDIFs on first "
     "init. Remove the container + its data volume (`docker compose down -v`) and restart, "
     "or use `ldapadd` live instead."],
    ["User can't log in via LDAP", "Verify `userNameFormat` matches the real DN pattern; "
     "test the bind directly with `ldapwhoami` as shown in section 6 before blaming Alfresco."],
    ["User logs in but has no profile / isn't visible in Share", "Synchronization subsystem "
     "is separate from authentication - confirm `ldap.synchronization.active=true` and that "
     "a sync job has actually run (check repository logs for 'LDAP' / 'ChainingUserRegistrySynchronizer')."],
    ["Synced user has a blank First Name or Last Name", "Expected for the `jonly` / "
     "`smithonly` seed accounts before the derive-names behaviour runs; confirm "
     "behaviour-derive-names-context.xml and derive-names-onCreateNode.js were copied into "
     "the image (check the alfresco container's extension folder) and look for "
     "'[derive-names]' log lines."],
    ["Need to start over completely", "`docker compose -f 26.N-compose-governance.yaml down -v` "
     "removes containers and volumes (including the LDAP database and the repository's "
     "Postgres data), then `up -d` rebuilds everything from the LDIF/XML/JS sources."],
]
t3 = Table(trouble_rows, colWidths=[2.3*inch, 4.4*inch])
t3.setStyle(TableStyle([
    ("BACKGROUND", (0,0), (-1,0), colors.HexColor("#2563EB")),
    ("TEXTCOLOR", (0,0), (-1,0), colors.white),
    ("FONTSIZE", (0,0), (-1,-1), 8.3),
    ("FONTNAME", (0,0), (-1,0), "Helvetica-Bold"),
    ("ROWBACKGROUNDS", (0,1), (-1,-1), [colors.white, colors.HexColor("#F3F4F6")]),
    ("GRID", (0,0), (-1,-1), 0.5, colors.HexColor("#D1D5DB")),
    ("VALIGN", (0,0), (-1,-1), "TOP"),
    ("TOPPADDING", (0,0), (-1,-1), 4),
    ("BOTTOMPADDING", (0,0), (-1,-1), 4),
]))
story.append(Spacer(1, 4))
story.append(t3)

# ---------- 9. Quick reference ----------
story.append(PageBreak())
story.append(Paragraph("9. Quick Reference Card", styles["SectionHeading"]))
ref_rows = [
    ["Setting", "Value"],
    ["Compose file", "docker-compose/26.N-compose-governance.yaml"],
    ["LDAP image", "osixia/openldap:1.5.0"],
    ["LDAP host:port (from Alfresco)", "openldap:389"],
    ["LDAP host:port (from host machine)", "localhost:389"],
    ["Base DN", "dc=example,dc=org"],
    ["User search base", "ou=users,dc=example,dc=org"],
    ["Group search base", "dc=example,dc=org"],
    ["Admin bind DN / password", "cn=admin,dc=example,dc=org / admin"],
    ["User DN pattern", "uid=%s,ou=users,dc=example,dc=org"],
    ["Test users / password", "jonly, smithonly, jdoe  /  password123"],
    ["Repository fallback login", "admin / admin (via alfrescoNtlm chain entry)"],
    ["Share URL", "http://localhost:8080/share"],
    ["Seed data file", "docker-compose/ldap-custom-ldif/50-users.ldif"],
    ["Name-fixup extension files", "behaviour-derive-names-context.xml, derive-names-onCreateNode.js"],
]
t4 = Table(ref_rows, colWidths=[2.6*inch, 4.1*inch])
t4.setStyle(TableStyle([
    ("BACKGROUND", (0,0), (-1,0), colors.HexColor("#2563EB")),
    ("TEXTCOLOR", (0,0), (-1,0), colors.white),
    ("FONTSIZE", (0,0), (-1,-1), 8.5),
    ("FONTNAME", (0,0), (-1,0), "Helvetica-Bold"),
    ("FONTNAME", (0,1), (0,-1), "Helvetica-Bold"),
    ("ROWBACKGROUNDS", (0,1), (-1,-1), [colors.white, colors.HexColor("#F3F4F6")]),
    ("GRID", (0,0), (-1,-1), 0.5, colors.HexColor("#D1D5DB")),
    ("VALIGN", (0,0), (-1,-1), "TOP"),
    ("TOPPADDING", (0,0), (-1,-1), 4),
    ("BOTTOMPADDING", (0,0), (-1,-1), 4),
]))
story.append(Spacer(1, 4))
story.append(t4)

doc.build(story)
print(f"PDF written to {OUTPUT_PATH}")

