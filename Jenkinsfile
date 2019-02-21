node {
    
    try {
    
    stage('*** Code CheckOut ***') {
        /* Let's make sure we have the repository cloned to our workspace */
            echo "Checking out Source Code"
            checkout scm
        }
        
        stage('*** Print Env Details ***') {
            echo "Branch Name: ${env.BRANCH_NAME}"
			echo "BUILD_NUMBER : ${env.BUILD_NUMBER}"
			echo "BUILD_ID : ${env.BUILD_ID}"
			echo "JOB_NAME: ${env.JOB_NAME}"
			echo "BUILD_TAG : ${env.BUILD_TAG}"
			echo "EXECUTOR_NUMBER : ${env.EXECUTOR_NUMBER}"
			echo "NODE_NAME: ${env.NODE_NAME}"
			echo "NODE_LABELS : ${env.NODE_LABELS}"
			echo "WORKSPACE : ${env.WORKSPACE}"
			echo "JENKINS_HOME : ${env.JENKINS_HOME}"
        }

         stage('*** Build Image ***') {
        /* This builds the actual image; synonymous to
         * docker build on the command line */
            echo "Build Stage Starting"
            sh "./build.sh"
        }
    
         stage('*** Testing Stage ***'){
        
            echo "Test Passed"
        }
}
    catch (e)| {
        // If there was an exception thrown, the build failed
        currentBuild.result = 'FAILED'
        throw e
    }
    finally {
        // Success or Failure, send notifications
        notifyBuild(currentBuild.result)
    }
}

def notifyBuild(String buildStatus = 'STARTED') {
	// build status of null means successful
	buildStatus = buildStatus ?: 'SUCCESS'

	// Default values
	def colorName = 'RED'
	def colorCode = '#FF0000'
	def subject = "${buildStatus}: Job '#${env.BUILD_NUMBER} of ${env.JOB_NAME}'"
	def summary = "${subject} at (${env.BUILD_URL}/console)"
	def details = """<p>STARTED: Job '#${env.BUILD_NUMBER} of ${env.JOB_NAME}':</p>
	    <p>Check console output at &QUOT;<a href='${env.BUILD_URL}/console'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>&QUOT;</p>"""

	// Override default values based on build status
	if (buildStatus == 'STARTED') {
		
		color = 'YELLOW'
		colorCode = '#FFFF00'

	}
	else if (buildStatus == 'SUCCESS') {
		
		color = 'GREEN'
		colorCode = '#00FF00'
	
	}
	else {
		color = 'RED'
		colorCode = '#FF0000'

	}

	// Send notifications
	slackSend (color: colorCode, message: summary)

	/*
	emailext (
		subject: subject,
		body: details,
		recipientProviders: [[$class: 'DevelopersRecipientProvider']]
	)
	*/
}

