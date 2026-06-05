export PATH=/usr/local/opt/ruby/bin:/Users/Jane/.gem/ruby/2.6.0/bin:$PATH:/opt/apache-maven-3.3.9/bin:/Users/Jane/Library/Python/3.9/bin
export JAVA_HOME=`/usr/libexec/java_home -v 21`
export HISTFILESIZE=10000

export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE=$HOME/.colima/default/docker.sock
export TESTCONTAINERS_HOST_OVERRIDE=$(colima ls -j | jq -r '.address')
export TESTCONTAINERS_HOST_OVERRIDE=localhost
export DOCKER_HOST="unix://${HOME}/.colima/default/docker.sock"

alias jdebug="java -agentlib:jdwp=transport=dt_socket,server=y,suspend=y,address=5005"

# open ports
alias ports="lsof -nP -i | grep LISTEN"

# maven builds
alias dependencycheck="mvn versions:display-dependency-updates"
alias plugincheck="mvn versions:display-plugin-updates"
alias mvn-debug="mvn -Dmaven.surefire.debug test"
mvnTest() {
  t=$1
  shift 1
  mvn test -Dtest=$t -DfailIfNoTests=false -Dsurefire.failIfNoSpecifiedTests=false $*
}
alias mvn-test=mvnTest
setVersion() {
    mvn versions:set versions:commit -DnewVersion=$1
}
alias setversion=setVersion
showMvnDependencies() {
    mvn dependency:tree | sed 's/\[INFO\]//g;s/+-//g;s/\\-//g;s/\|//g;s/:compile//g' | sed -e 's/^[ \t]*//' | sort | uniq
}
alias mvndepend=showMvnDependencies
buildLibs() {
  pushd /Users/Jane/Code/something
  resumeBuild
}
resumeBuild() {
  until [ $? -ne 0 ]
  do
    git fetch
    if [ $? -ne 0 ]
    then
      return
    fi
    git rebase origin/main
    mvn clean install
    if [ $? -ne 0 ]
    then
      return
    fi
    popd
  done
}
alias buildlibs=buildLibs
alias resumebuild=resumeBuild
alias gradlewVersion="./gradlew -Pversion=0-jane"
alias intellij="./gradlew idea;open *.ipr"

# testing helpers
alias show_results="find . -type d -name surefire-reports -exec grep -lR FAIL {} \;; find . -type d -name failsafe-reports -exec grep -lR FAIL {} \;"
alias post="curl -X POST -H \"Content-Type: application/json\""

# release helpers
alias puppet-encode='eyaml encrypt -s'

export PROMPT_COMMAND='history -a; history -r'

alias camera="sudo killall VDCAssistant"
alias gitagent="ssh-agent;ssh-add ~/.ssh/id_rsa"
alias snapshottags="git tag -l --format='%(creatordate:short)	%(refname:short)' | grep SNAPSHOT | sort -r"
gitMerged() {
  git branch -r --format='%(creatordate:short) %(refname:short)' --merged origin/master | sort -r
}
alias gitmerged=gitMerged
alias gitrefresh='for directory in ./*; do pushd $directory; git fetch; git rebase; popd; done'

#alias j7="export JAVA_HOME=`/usr/libexec/java_home -v 1.7`; java -version"
alias j8="export JAVA_HOME=`/usr/libexec/java_home -v 1.8`; java -version"
alias j9="export JAVA_HOME=`/usr/libexec/java_home -v 9`; java -version"
alias j10="export JAVA_HOME=`/usr/libexec/java_home -v 10`; java -version"
alias j11="export JAVA_HOME=`/usr/libexec/java_home -v 11`; java -version"
alias j11.0.2="export JAVA_HOME=`/usr/libexec/java_home -v 11.0.2`; java -version"
alias j17="export JAVA_HOME=`/usr/libexec/java_home -v 17`; java -version"
alias j20="export JAVA_HOME=`/usr/libexec/java_home -v 20`; java -version"
alias j21="export JAVA_HOME=`/usr/libexec/java_home -v 21`; java -version"
alias j22="export JAVA_HOME=`/usr/libexec/java_home -v 22`; java -version"
alias j23="export JAVA_HOME=`/usr/libexec/java_home -v 23`; java -version"
alias j24="export JAVA_HOME=`/usr/libexec/java_home -v 24`; java -version"

#find with prune
findPrune() {
  w=$1
  shift 1
  find $w -name ".git" -prune -o -name ".terragrunt-cache" -prune -o -name ".gradle" -prune -o -name "build" -prune -o $*
}
alias findprune=findPrune
alias dockerclean="docker kill \`docker ps -q\`;docker rm \`docker ps -qa\`"
alias colimastart="colima start --arch aarch64"
alias colimastop="limactl stop -f colima"

#certificates
getPem() {
  s=$1
  shift 1
  #echo | openssl s_client -showcerts -servername $s -connect $s:443 2>/dev/null | openssl x509 $*
  echo | openssl s_client -servername $s -connect $s:443 2>/dev/null | openssl x509 $*
}
alias getpem=getPem

checkCert() {
  echo | openssl s_client -showcerts -servername $1 -connect $1:443 2>/dev/null | openssl x509 -inform pem -noout -text
}
alias checkcert=checkCert
alias port="lsof -i TCP:8000"
alias pythonlocal="source /Users/Jane/Code/exercises/python/bin/activate"
