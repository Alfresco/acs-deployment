"""
Generates PDF documentation describing the Alfresco supporting services
launched by supporting_jar_files/start-all.sh.
"""
from reportlab.lib.pagesizes import LETTER
from reportlab.lib.units import inch
from reportlab.lib import colors
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.platypus import (
    SimpleDocTemplate, Paragraph, Spacer, Table, TableStyle, PageBreak, ListFlowable, ListItem
)
from reportlab.lib.enums import TA_CENTER

OUTPUT_PATH = r"C:\AlfrescoWork\alfresco_install_location\supporting_jar_files\Alfresco_Supporting_Services_Documentation.pdf"

styles = getSampleStyleSheet()
styles.add(ParagraphStyle(name="TitleBig", fontSize=24, leading=28, spaceAfter=10, alignment=TA_CENTER, textColor=colors.HexColor("#1F2937")))
styles.add(ParagraphStyle(name="Subtitle", fontSize=13, leading=18, alignment=TA_CENTER, textColor=colors.HexColor("#4B5563"), spaceAfter=6))
styles.add(ParagraphStyle(name="SectionHeading", fontSize=16, leading=20, spaceBefore=18, spaceAfter=8, textColor=colors.HexColor("#111827")))
styles.add(ParagraphStyle(name="ServiceHeading", fontSize=13, leading=16, spaceBefore=14, spaceAfter=4, textColor=colors.white, backColor=colors.HexColor("#2563EB"), leftIndent=6, borderPadding=(4,4,4,4)))
styles.add(ParagraphStyle(name="SubHeading", fontSize=10.5, leading=13, spaceBefore=6, spaceAfter=2, textColor=colors.HexColor("#1D4ED8")))
styles.add(ParagraphStyle(name="Body", fontSize=10, leading=14, spaceAfter=4))
styles.add(ParagraphStyle(name="Mono", fontName="Courier", fontSize=8.7, leading=11, backColor=colors.HexColor("#F3F4F6"), leftIndent=6, spaceAfter=6, spaceBefore=2))
styles.add(ParagraphStyle(name="Small", fontSize=8.5, leading=11, textColor=colors.HexColor("#6B7280")))

doc = SimpleDocTemplate(
    OUTPUT_PATH, pagesize=LETTER,
    leftMargin=0.85*inch, rightMargin=0.85*inch,
    topMargin=0.8*inch, bottomMargin=0.8*inch,
    title="Alfresco Supporting Services & Jar Files",
    author="Alfresco Deployment Documentation",
)

story = []

# ---------- Title page ----------
story.append(Spacer(1, 1.2*inch))
story.append(Paragraph("Alfresco Supporting Services & Jar Files", styles["TitleBig"]))
story.append(Paragraph("Purpose, Rationale, and Installation Guide", styles["Subtitle"]))
story.append(Spacer(1, 0.3*inch))
story.append(Paragraph(
    "Based on: <font face='Courier'>supporting_jar_files/start-all.sh</font><br/>"
    "Location: C:\\AlfrescoWork\\alfresco_install_location\\supporting_jar_files",
    styles["Small"]
))
story.append(Spacer(1, 2.2*inch))
story.append(Paragraph(
    "This document explains the auxiliary services that a standalone Alfresco Content "
    "Services (ACS) repository depends on for messaging, search indexing, and content "
    "transformation, why each one is required, and how it is installed and started.",
    styles["Body"]
))
story.append(PageBreak())

# ---------- Overview ----------
story.append(Paragraph("1. Overview", styles["SectionHeading"]))
story.append(Paragraph(
    "Modern Alfresco Content Services deployments are composed of the core Repository "
    "(and Share/ADW) plus several independent companion services. These services "
    "communicate with the Repository over HTTP and JMS rather than running in the same "
    "process, which lets each one be scaled, upgraded, or replaced independently. The "
    "<font face='Courier'>start-all.sh</font> script in the "
    "<font face='Courier'>supporting_jar_files</font> folder is a local/development convenience "
    "launcher: it opens one console window per service so a developer can bring up a full "
    "working stack on a single Windows machine without Docker.",
    styles["Body"]
))
story.append(Paragraph(
    "The script starts the following components, in this order:",
    styles["Body"]
))

overview_rows = [
    ["#", "Service", "Component", "Port"],
    ["1", "ActiveMQ", "apache-activemq-6.3.0", "61616 / 8161"],
    ["2", "Elasticsearch", "elasticsearch-8.19.12", "9200 / 9300"],
    ["3", "Shared File Store", "alfresco-shared-file-store-4.4.3.jar", "8099"],
    ["4", "Transform Core AIO", "alfresco-transform-core-aio-5.4.5-A.1.jar", "8090"],
    ["5", "ES Live Indexing", "alfresco-elasticsearch-live-indexing-5.8.0-A.1.jar", "8083"],
    ["6", "ES Reindexing", "alfresco-elasticsearch-reindexing-5.8.0-A.1.jar", "8084"],
]
t = Table(overview_rows, colWidths=[0.3*inch, 1.5*inch, 3.1*inch, 1.0*inch])
t.setStyle(TableStyle([
    ("BACKGROUND", (0,0), (-1,0), colors.HexColor("#2563EB")),
    ("TEXTCOLOR", (0,0), (-1,0), colors.white),
    ("FONTSIZE", (0,0), (-1,-1), 8.5),
    ("FONTNAME", (0,0), (-1,0), "Helvetica-Bold"),
    ("ROWBACKGROUNDS", (0,1), (-1,-1), [colors.white, colors.HexColor("#F3F4F6")]),
    ("GRID", (0,0), (-1,-1), 0.5, colors.HexColor("#D1D5DB")),
    ("VALIGN", (0,0), (-1,-1), "MIDDLE"),
    ("TOPPADDING", (0,0), (-1,-1), 4),
    ("BOTTOMPADDING", (0,0), (-1,-1), 4),
]))
story.append(Spacer(1, 6))
story.append(t)
story.append(Spacer(1, 8))
story.append(Paragraph(
    "The startup order is deliberate: the message broker and search engine are "
    "infrastructure that the other services depend on, so they are started first; the "
    "Shared File Store and Transform service are started next because content rendition "
    "needs both; the Elasticsearch connector services are started last because they need "
    "both ActiveMQ and Elasticsearch already running.",
    styles["Body"]
))

# ---------- How the script works ----------
story.append(Paragraph("2. How start-all.sh Works", styles["SectionHeading"]))
story.append(Paragraph(
    "The script defines a helper function, <font face='Courier'>open_window</font>, that opens "
    "a new Windows <font face='Courier'>cmd</font> console for each service, changes into that "
    "service's directory, and runs its start command with <font face='Courier'>cmd /k</font> so "
    "the window stays open and shows live logs. It is a Git Bash script, calling the native "
    "Windows <font face='Courier'>cmd //c start</font> command to spawn each window:",
    styles["Body"]
))
story.append(Paragraph(
    "open_window(title, dir, cmd) &rarr; cmd //c start \"title\" cmd //k \"cd /d dir &amp;&amp; cmd\"",
    styles["Mono"]
))
story.append(Paragraph(
    "Equivalent <font face='Courier'>start-all.bat</font> and <font face='Courier'>start-all.ps1</font> "
    "versions exist in the same folder for use outside of a bash shell.",
    styles["Body"]
))

story.append(PageBreak())

# ---------- Service details ----------
story.append(Paragraph("3. Service-by-Service Reference", styles["SectionHeading"]))

def service_section(title, subtitle, purpose, why, install_steps, start_cmd, port, notes=None):
    story.append(Paragraph(title, styles["ServiceHeading"]))
    story.append(Paragraph(subtitle, styles["Small"]))
    story.append(Paragraph("Purpose", styles["SubHeading"]))
    story.append(Paragraph(purpose, styles["Body"]))
    story.append(Paragraph("Why it needs to be installed", styles["SubHeading"]))
    story.append(Paragraph(why, styles["Body"]))
    story.append(Paragraph("How to install", styles["SubHeading"]))
    story.append(ListFlowable(
        [ListItem(Paragraph(s, styles["Body"])) for s in install_steps],
        bulletType="1", start=1, leftIndent=16
    ))
    story.append(Paragraph("Start command (used by start-all.sh)", styles["SubHeading"]))
    story.append(Paragraph(start_cmd, styles["Mono"]))
    story.append(Paragraph(f"<b>Default port(s):</b> {port}", styles["Body"]))
    if notes:
        story.append(Paragraph("Notes", styles["SubHeading"]))
        story.append(Paragraph(notes, styles["Body"]))
    story.append(Spacer(1, 6))

service_section(
    "3.1  Apache ActiveMQ 6.3.0",
    "Directory: apache-activemq-6.3.0",
    "ActiveMQ is a JMS (Java Message Service) message broker. It is the asynchronous "
    "messaging backbone that lets the Alfresco Repository hand off work &mdash; such as "
    "content transformation requests, thumbnail/preview generation, and content-change "
    "events &mdash; to other services without waiting for them to respond directly.",
    "The Repository, Transform Service, and Elasticsearch connector services do not call "
    "each other synchronously over HTTP for these workflows; they publish and consume "
    "messages on queues/topics hosted by ActiveMQ. Without a running broker, transform "
    "requests queue up and fail, thumbnails/previews stop generating, and change events "
    "used to keep the search index in sync are never delivered.",
    [
        "Download the Apache ActiveMQ &ldquo;Classic&rdquo; distribution (version 6.3.0, or the "
        "version listed in Alfresco's supported-stack matrix for your ACS release).",
        "Extract the archive to <font face='Courier'>supporting_jar_files\\apache-activemq-6.3.0</font>.",
        "(Optional) Edit <font face='Courier'>conf/activemq.xml</font> to change the default ports "
        "or enable persistence settings.",
        "Point the Repository at the broker by setting "
        "<font face='Courier'>messaging.broker.url=failover:tcp://localhost:61616</font> in "
        "<font face='Courier'>alfresco-global.properties</font>.",
    ],
    "activemq start&nbsp;&nbsp;(run from apache-activemq-6.3.0\\bin)",
    "61616 (OpenWire/JMS), 8161 (web admin console)",
    "The web console at <font face='Courier'>http://localhost:8161/admin</font> "
    "(default admin/admin) is useful for inspecting queues and diagnosing stuck messages.",
)

service_section(
    "3.2  Elasticsearch 8.19.12",
    "Directory: elasticsearch-8.19.12",
    "Elasticsearch is the search and indexing engine behind Alfresco Search Enterprise "
    "(ASE). It stores a searchable index of repository content, metadata, and "
    "permissions, and answers the full-text/metadata search queries issued from Share, "
    "ADW, and the public Search API.",
    "Without a running Elasticsearch cluster there is nowhere for content to be indexed, "
    "so repository search returns no results (or the deployment must fall back to a "
    "different search subsystem such as Solr, if configured). It underpins one of the "
    "most visible end-user features of Alfresco.",
    [
        "Download Elasticsearch 8.19.12 matching the version certified for your Alfresco "
        "Search Enterprise release.",
        "Extract to <font face='Courier'>supporting_jar_files\\elasticsearch-8.19.12</font>.",
        "Configure <font face='Courier'>config/elasticsearch.yml</font> (cluster name, network "
        "host, security/TLS settings, JVM heap in <font face='Courier'>jvm.options</font>).",
        "For local/dev use, security features are often disabled "
        "(<font face='Courier'>xpack.security.enabled: false</font>); for production, TLS and "
        "authentication should be enabled.",
    ],
    "elasticsearch&nbsp;&nbsp;(run from elasticsearch-8.19.12\\bin)",
    "9200 (HTTP REST API), 9300 (internal transport)",
    "The related folder <font face='Courier'>alfresco-elasticsearch-connector-distribution-5.7.1-A.2</font> "
    "(not launched by this script) ships a reference docker-compose setup and licenses for "
    "the full Elasticsearch Connector stack, useful as a configuration reference.",
)

service_section(
    "3.3  Alfresco Shared File Store (alfresco-shared-file-store-4.4.3.jar)",
    "Standalone Spring Boot service",
    "The Shared File Store (SFS) is a small HTTP microservice that provides temporary, "
    "addressable storage for binary content that needs to move between the Repository "
    "and the Transform Service.",
    "The Repository and the Transform Service run as separate processes (often on "
    "separate hosts/containers) and do not share a filesystem. When the Repository asks "
    "for a rendition, thumbnail, or format conversion, it uploads the source file to SFS, "
    "sends the Transform Service a reference to it, and later retrieves the transformed "
    "output from SFS. Without SFS running, transformation requests cannot exchange files "
    "and will fail.",
    [
        "Obtain <font face='Courier'>alfresco-shared-file-store-4.4.3.jar</font> matching the "
        "version in Alfresco's compatibility matrix for your ACS release.",
        "Place the jar in <font face='Courier'>supporting_jar_files</font>.",
        "Configure the Repository's <font face='Courier'>alfresco-global.properties</font> so "
        "<font face='Courier'>transform.service.enabled=true</font> and the file store URL "
        "points at this service, e.g. "
        "<font face='Courier'>sfs.url=http://localhost:8099/</font>.",
    ],
    "java -jar alfresco-shared-file-store-4.4.3.jar --server.port=8099",
    "8099",
    None,
)

service_section(
    "3.4  Transform Core AIO (alfresco-transform-core-aio-5.4.5-A.1.jar)",
    "Standalone Spring Boot service &mdash; &ldquo;All-In-One&rdquo; transformer bundle",
    "The Transform Service converts content between formats and generates previews, "
    "thumbnails, and extracted metadata. The &ldquo;AIO&rdquo; (All-In-One) jar bundles all of "
    "the standard transformer engines &mdash; LibreOffice (Office documents), ImageMagick "
    "(images), PDF Renderer, Tika (metadata/text extraction), and miscellaneous transforms "
    "&mdash; into a single deployable service.",
    "Document preview, thumbnail generation in Share/ADW, and metadata extraction all "
    "depend on this service. Without it, uploads succeed but renditions never appear "
    "(no thumbnails, no PDF preview), and searches that rely on extracted text/metadata "
    "are degraded.",
    [
        "Obtain <font face='Courier'>alfresco-transform-core-aio-5.4.5-A.1.jar</font> matching "
        "the ACS compatibility matrix.",
        "Place the jar in <font face='Courier'>supporting_jar_files</font>.",
        "Ensure the Shared File Store is running first, since the AIO service reads/writes "
        "content through it.",
        "Configure the Repository to call this service, e.g. "
        "<font face='Courier'>localTransform.core-aio.url=http://localhost:8090/</font> in "
        "<font face='Courier'>alfresco-global.properties</font>.",
    ],
    "java -jar alfresco-transform-core-aio-5.4.5-A.1.jar --server.port=8090",
    "8090",
    "The AIO jar bundles native dependencies for the transformers it includes; on Windows "
    "some transforms (e.g. LibreOffice-based ones) may require the underlying binaries to "
    "be present and licensed appropriately for production use.",
)

story.append(PageBreak())

service_section(
    "3.5  Elasticsearch Live Indexing (alfresco-elasticsearch-live-indexing-5.8.0-A.1.jar)",
    "Standalone Spring Boot service",
    "Live Indexing listens for repository change events (node create/update/delete, "
    "permission changes) published to ActiveMQ and applies the corresponding updates to "
    "the Elasticsearch index in near real time.",
    "Elasticsearch has no built-in awareness of the Alfresco repository; something has to "
    "translate repository change events into index updates. Without Live Indexing "
    "running, search results become stale &mdash; new or edited content will not appear "
    "in search until a manual reindex is run.",
    [
        "Obtain <font face='Courier'>alfresco-elasticsearch-live-indexing-5.8.0-A.1.jar</font> "
        "matching the ACS/ASE compatibility matrix.",
        "Ensure ActiveMQ and Elasticsearch are both already running &mdash; this service is a "
        "consumer of the broker and a writer to the search index.",
        "Configure its connection properties (broker URL, Elasticsearch host/port, index "
        "name) via command-line flags or an application.properties file alongside the jar.",
    ],
    "java -jar alfresco-elasticsearch-live-indexing-5.8.0-A.1.jar --server.port=8083",
    "8083",
    None,
)

service_section(
    "3.6  Elasticsearch Reindexing (alfresco-elasticsearch-reindexing-5.8.0-A.1.jar)",
    "Standalone Spring Boot service / utility",
    "Reindexing performs a full (or metadata-only) bulk index of existing repository "
    "content into Elasticsearch. It is the counterpart to Live Indexing: Live Indexing "
    "keeps the index current going forward, while Reindexing (re)builds it from scratch.",
    "It is needed the first time a new Elasticsearch deployment is populated, after an "
    "index mapping change, or to recover from index corruption or extended broker "
    "downtime where change events were missed.",
    [
        "Obtain <font face='Courier'>alfresco-elasticsearch-reindexing-5.8.0-A.1.jar</font> "
        "matching the ACS/ASE compatibility matrix.",
        "Ensure ActiveMQ, Elasticsearch, and the Repository are running first.",
        "Start the service, then trigger a reindex job through its REST API and monitor "
        "progress via its status endpoint.",
    ],
    "java -jar alfresco-elasticsearch-reindexing-5.8.0-A.1.jar --server.port=8084",
    "8084",
    "This service is typically run on demand rather than left running continuously in "
    "production; the local start-all.sh script starts it alongside everything else purely "
    "for developer convenience.",
)

# ---------- Running the stack ----------
story.append(Paragraph("4. Running the Full Stack", styles["SectionHeading"]))
story.append(Paragraph(
    "From a Git Bash shell in the <font face='Courier'>supporting_jar_files</font> directory:",
    styles["Body"]
))
story.append(Paragraph("./start-all.sh", styles["Mono"]))
story.append(Paragraph(
    "This opens six console windows, one per service, each running in the foreground so "
    "logs are visible and the service can be stopped with Ctrl+C in its own window. "
    "Windows users who are not using Git Bash can instead run the equivalent "
    "<font face='Courier'>start-all.bat</font> or <font face='Courier'>start-all.ps1</font> "
    "scripts in the same folder.",
    styles["Body"]
))
story.append(Paragraph(
    "Prerequisites checklist",
    styles["SubHeading"]
))
story.append(ListFlowable(
    [ListItem(Paragraph(s, styles["Body"])) for s in [
        "A JDK (matching the version required by your ACS release) installed and on PATH "
        "&mdash; all four Java services and ActiveMQ require it.",
        "Sufficient free RAM: Elasticsearch, the Transform AIO service, and ActiveMQ are "
        "each JVM processes with non-trivial heap requirements.",
        "No port conflicts on 61616, 8161, 9200, 9300, 8099, 8090, 8083, 8084.",
        "The Alfresco Repository's <font face='Courier'>alfresco-global.properties</font> "
        "configured with matching URLs/ports for each service above.",
    ]],
    bulletType="bullet", leftIndent=16
))
story.append(Paragraph(
    "This launcher is intended for local development and testing. For production or "
    "shared environments, run these components as managed OS services or containers "
    "(e.g. via the docker-compose reference in "
    "<font face='Courier'>alfresco-elasticsearch-connector-distribution-5.7.1-A.2</font>) "
    "rather than as foreground console processes.",
    styles["Body"]
))

doc.build(story)
print(f"PDF written to {OUTPUT_PATH}")
