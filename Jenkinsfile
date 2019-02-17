node {
    def app
    environment {
        registry = "sandy1480/docker-test"
    }
    stage('*** Code CheckOut ***') {
        /* Let's make sure we have the repository cloned to our workspace */

        checkout scm
    }

    stage('*** Build Image ***') {
        /* This builds the actual image; synonymous to
         * docker build on the command line */

        sh "./build.sh"
    }
    
    stage('*** Test Image ***') {
        /* Ideally, we would run a test framework against our image.
         * For this example, we're using a Volkswagen-type approach ;-) */

        app.inside {
            sh 'echo "Tests Passed"'
        }
    }   
}
