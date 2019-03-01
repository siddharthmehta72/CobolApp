node {
       def app
    try {
    
         stage('*** Code CheckOut ***') {
        /* Let's make sure we have the repository cloned to our workspace */
            echo "Checking out Source Code"
            checkout scm
        }
        
         stage('*** Build Image ***') {
        /* This builds the actual image; synonymous to
         * docker build on the command line */
            echo "Build Stage Starting"
            app = docker.build("cobimage:${env.BUILD_ID}")
        } 
	 
         stage('*** Deploy to Container ***'){
             echo "Deploy Stage Starting" 
             app.run("--name CobApp-${env.BUILD_ID} -p 8090:8090 -v ~/container_dir:/data")
	}	    
         stage('*** Testing Stage by Postman ***'){
            echo "Testing Stage Starting"
            sh "npm install"
            try {
                sh "npm run api-test"
                currentBuild.result = 'SUCCESS'
            } catch (Exception ex){
                        currentBuild.result = 'FAILURE'
                    }
           junit 'newman.xml'
        }
         stage('*** Stop Running Container ***'){
             echo "Stop Stage Starting" 
             container.stop()
	}	    
}
    catch (e) {
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
        slackSend baseUrl: 'https://hooks.slack.com/services/',
		  channel: 'jenkins-slack',
		  color: colorCode,
		  message: summary,
		  teamDomain: 'NinjaDevOps',
		  tokenCredentialId: 'slack-id'
}
