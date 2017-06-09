MAJOR_VERSION = "1"
ARTIFACTS_BUCKET = "my-artifacts-bucket"
SERVICE = "example-service"
node {
    stage('Checkout service repo') {
        dir('project') {
            git 'https://github.com/SC5/serverless-deployment-example-service.git'
        }
    }

    stage('Set version') {
        dir('project') {
            gitCommitShort = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
            version = VersionNumber(projectStartDate: '2016-10-01', skipFailedBuilds: true, versionNumberString: '${BUILD_DATE_FORMATTED, "yyyyMMdd"}.${BUILDS_TODAY, X}-${gitCommitShort}', versionPrefix: "${MAJOR_VERSION}.")
            currentVersion = "${version}" + "${gitCommitShort}"

        }
    }

    stage('Build') {
        dir('project') {
            withEnv(["VERSION=${currentVersion}"]) {
                sh "./scripts/create-artifact.sh -s ${SERVICE}"
            }
        }
    }
}