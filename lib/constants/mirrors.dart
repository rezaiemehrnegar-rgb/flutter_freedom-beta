// ─── Env Var Mirrors (Step 1) ───────────────────────────────────────────────

enum EnvMirror { myket, runflare, chinese, taraz, devneeds }

class EnvMirrorData {
  final EnvMirror mirror;
  final String name;
  final String pubHostedUrl;
  final String flutterStorageBaseUrl;

  const EnvMirrorData({
    required this.mirror,
    required this.name,
    required this.pubHostedUrl,
    required this.flutterStorageBaseUrl,
  });
}

const List<EnvMirrorData> envMirrors = [
  EnvMirrorData(
    mirror: EnvMirror.myket,
    name: 'mirrorMyket',
    pubHostedUrl: 'https://pub.myket.ir',
    flutterStorageBaseUrl: 'https://pub.myket.ir',
  ),
  EnvMirrorData(
    mirror: EnvMirror.runflare,
    name: 'mirrorRunflare',
    pubHostedUrl: 'https://mirror-flutter.runflare.com',
    flutterStorageBaseUrl: 'https://mirror-gcs.runflare.com',
  ),
  EnvMirrorData(
    mirror: EnvMirror.chinese,
    name: 'mirrorChinese',
    pubHostedUrl: 'https://pub.flutter-io.cn',
    flutterStorageBaseUrl: 'https://storage.flutter-io.cn',
  ),
  EnvMirrorData(
    mirror: EnvMirror.taraz,
    name: 'mirrorTaraz',
    pubHostedUrl: 'https://pub.tarazerp.ir',
    flutterStorageBaseUrl: 'https://flutter.tarazerp.ir',
  ),
  EnvMirrorData(
    mirror: EnvMirror.devneeds,
    name: 'mirrorDevNeeds',
    pubHostedUrl: 'https://dart.devneeds.ir',
    flutterStorageBaseUrl: 'https://flutter.devneeds.ir',
  ),
];

// ─── Gradle Init Mirrors (Step 2) ───────────────────────────────────────────

enum GradleInitMirror { myket, taraz }

class GradleInitMirrorData {
  final GradleInitMirror mirror;
  final String name;
  final String fileContent;

  const GradleInitMirrorData({
    required this.mirror,
    required this.name,
    required this.fileContent,
  });
}

const String _myketMavenMirror = r'''
import org.gradle.api.artifacts.dsl.RepositoryHandler
import org.gradle.api.artifacts.repositories.MavenArtifactRepository

val MIRROR = "https://maven.myket.ir"

val REDIRECT_HOSTS = setOf(
    "repo.maven.apache.org",
    "repo1.maven.org",
    "dl.google.com",
    "maven.google.com",
    "plugins.gradle.org",
    "jitpack.io",
    "jcenter.bintray.com",
    "maven.fabric.io",
    "developer.huawei.com",
    "storage.googleapis.com",
)

fun shouldRedirect(url: String): Boolean =
    REDIRECT_HOSTS.any { host -> url.contains(host, ignoreCase = true) }

fun interceptRepos(repos: RepositoryHandler) {
    repos.whenObjectAdded {
        val repo = this as? MavenArtifactRepository ?: return@whenObjectAdded
        val original = repo.url.toString()
        if (shouldRedirect(original)) {
            println("[Myket Mirror] Redirecting: $original -> $MIRROR")
            repo.setUrl(MIRROR)
        }
    }
}

gradle.beforeSettings {
    pluginManagement {
        interceptRepos(repositories)
        repositories {
            maven(url = MIRROR)
        }
    }
    @Suppress("UnstableApiUsage")
    dependencyResolutionManagement {
        interceptRepos(repositories)
        repositories {
            maven(url = MIRROR) {
                name = "myket-mirror"
            }
        }
    }
}

gradle.allprojects {
    buildscript {
        interceptRepos(repositories)
        repositories {
            clear()
            maven(url = MIRROR)
        }
    }
    interceptRepos(repositories)
    repositories.whenObjectAdded {
        val repo = this as? MavenArtifactRepository ?: return@whenObjectAdded
        val original = repo.url.toString()
        if (shouldRedirect(original)) {
            println("[Myket Mirror] Redirecting project repo: $original -> $MIRROR")
            repo.setUrl(MIRROR)
        }
    }
}
''';

const String _tarazMavenMirror = r'''
import org.gradle.api.artifacts.dsl.RepositoryHandler
import org.gradle.api.artifacts.repositories.MavenArtifactRepository

val MIRROR = "https://maven.tarazerp.ir"

val REDIRECT_HOSTS = setOf(
    "repo.maven.apache.org",
    "repo1.maven.org",
    "dl.google.com",
    "maven.google.com",
    "plugins.gradle.org",
    "jitpack.io",
    "jcenter.bintray.com",
    "maven.fabric.io",
    "developer.huawei.com",
    "storage.googleapis.com",
)

fun shouldRedirect(url: String) = REDIRECT_HOSTS.any { url.contains(it) }

fun interceptRepos(repos: RepositoryHandler) {
    repos.whenObjectAdded {
        if (this is MavenArtifactRepository) {
            val original = this.url.toString()
            if (shouldRedirect(original)) {
                logger.info("[Tarazerp Mirror] Redirecting: $original -> $MIRROR")
                this.setUrl(MIRROR)
            }
        }
    }
}

gradle.beforeSettings {
    pluginManagement {
        interceptRepos(repositories)
        repositories {
            maven(url = MIRROR)
        }
    }
    @Suppress("UnstableApiUsage")
    dependencyResolutionManagement {
        interceptRepos(repositories)
        repositories {
            maven(url = MIRROR) { name = "flutter-mirror" }
        }
    }
}

gradle.allprojects {
    buildscript {
        interceptRepos(repositories)
        repositories {
            clear()
            maven(url = MIRROR)
        }
    }
    interceptRepos(repositories)
}
''';

const List<GradleInitMirrorData> gradleInitMirrors = [
  GradleInitMirrorData(
    mirror: GradleInitMirror.myket,
    name: 'mirrorMyket',
    fileContent: _myketMavenMirror,
  ),
  GradleInitMirrorData(
    mirror: GradleInitMirror.taraz,
    name: 'mirrorTaraz',
    fileContent: _tarazMavenMirror,
  ),
];

// ─── Gradle Wrapper Mirrors (Step 3) ────────────────────────────────────────

enum GradleWrapperMirror { myket, runflare, taraz, devneeds }

class GradleWrapperMirrorData {
  final GradleWrapperMirror mirror;
  final String name;
  // {version} will be replaced with the actual gradle version string
  // e.g. "8.13-bin" or "8.7-all"
  final String distributionUrlTemplate;

  const GradleWrapperMirrorData({
    required this.mirror,
    required this.name,
    required this.distributionUrlTemplate,
  });

  String buildUrl(String version) =>
      distributionUrlTemplate.replaceAll('{version}', version);
}

const List<GradleWrapperMirrorData> gradleWrapperMirrors = [
  GradleWrapperMirrorData(
    mirror: GradleWrapperMirror.myket,
    name: 'mirrorMyket',
    distributionUrlTemplate:
        r'https\://maven.myket.ir/gradle/distributions/gradle-{version}.zip',
  ),
  GradleWrapperMirrorData(
    mirror: GradleWrapperMirror.runflare,
    name: 'mirrorRunflare',
    distributionUrlTemplate:
        r'https\://mirror-maven.runflare.com/distributions/gradle-{version}.zip',
  ),
  GradleWrapperMirrorData(
    mirror: GradleWrapperMirror.taraz,
    name: 'mirrorTaraz',
    distributionUrlTemplate:
        r'https\://flutter.tarazerp.ir/gradle/distributions/gradle-{version}.zip',
  ),
  GradleWrapperMirrorData(
    mirror: GradleWrapperMirror.devneeds,
    name: 'mirrorDevNeeds',
    distributionUrlTemplate:
        r'https\://gradle.devneeds.ir/gradle-{version}.zip',
  ),
];

// ─── Auto Setup defaults ─────────────────────────────────────────────────────

const EnvMirror autoSetupEnvMirror = EnvMirror.myket;
const GradleInitMirror autoSetupGradleInitMirror = GradleInitMirror.myket;
