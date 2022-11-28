# PGR301 Eksamen stkl002

## Del 1 - DevOps-prinsipper
Hva er utfordringene med dagens systemutviklingsprosess - og hvordan vil innføring av DevOps kunne være med på å løse disse? Hvilke DevOps prinsipper blir brutt?
- asdf
- asdf

En vanlig respons på mange feil under release av ny funksjonalitet er å gjøre det mindre hyppig, og samtidig forsøke å legge på mer kontroll og QA. Hva er problemet med dette ut ifra et DevOps perspektiv, og hva kan være en bedre tilnærming?
- asdf
- asdf

Teamet overleverer kode til en annen avdeling som har ansvar for drift - hva er utfordringen med dette ut ifra et DevOps perspektiv, og hvilke gevinster kan man få ved at team han ansvar for både drift- og utvikling?
- asdfa
- asdf

Å release kode ofte kan også by på utfordringer. Beskriv hvilke- og hvordan vi kan bruke DevOps prinsipper til å redusere eller fjerne risiko ved hyppige leveraner.
- asdfa
- asdfas



## Del 2 - CI

### Oppgave 1 
CI workflowen kjører nå etter å ha lagt til dette i ci.yml filen:
```
on:
    push:
        branches: [ main ]
    pull_request:
        branches: [ main ]
```


### OBS! Oppgave 2 ** TESTING NEEDED IN THE END **
CI workflowen kjører nå på hver eneste push, uavhengig av branch **TEST THIS WITH DUMMY USER**
etter å ha fått "Build with Maven" jobben til å kjøre med dette:
```
 - name: Build with Maven
        run: mvn -B package --file pom.xml
```
Så istedenfor å bare compilere, vil den nå kjøre testene før den blir pakke.

### OBS! Oppgave 3 ** LEGG TIL TERRAFORM OG TA BILDE NÅR DET ER GJORT **
Sensor må gå inn i settings i repoet:
[insert bilde av første side man kommer til]
Her må man trykke på "Add rule" for å legge til en regel i branchen slik at 
en f.eks. ikke kan pushe direkte til main.

For at ingen kan pushe direkte til må man velge hvilken branch regelen skal 
fungere på. Som i vårt case er "main".
Da under "Protect matching branches" hukker man av på 
- [x] Require a pull request before merging

Slik at en ikke kan pushe direkte til main men kun med en Pull request.
- [x] Require approvals

Slik at kode kan Merges til main ved å lage en Pull request med minst en godkjenning
- [x] Require status check to pass before merging

Slik at kode some merges til main blir verifisert av Github Actions ved å kjøre workflow actions valgt og sjekke om disse passere 
 
[insert bilde av settings side med branches valgt og sånt]



## Del 3 - Docker

### OBS! Oppgave 1
For å få workflowen til å fungere med DockerHub kontoen min må jeg legge til 
secrets i repoet i Github, da workflown spesifikt ser etter en sercet som 
heter "DOCKER_HUB_USERNAME" og "DOCKER_HUB_TOKEN".
Den failer og får "Error: Username and password required" da den ikke 
har en username og passord å skrive inn.

[insert bilde av Settings > secrets > actions side]

### Oppgave 2
Satt på en Builder på Dockerfilen med 
```
FROM maven:3.6-jdk-11 as builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn package
```
og fikset java versionen til å kunne kjøre class file version 55 (java11) og 
bruker builderen
```
FROM adoptopenjdk/openjdk11:alpine-slim
COPY --from=builder /app/target/*.jar  /app/application.jar
ENTRYPOINT ["java","-jar","/app/application.jar"]
```

Fjernet også steget i docker.yml filen som packet filen og skippet alle 
testene..

```
      - name: Set up JDK 11
        uses: actions/setup-java@v2
        with:
          java-version: '11'
          distribution: 'adopt'
          cache: maven

      - name: Build with Maven
        # Jim; Just skipping test for now
        run: mvn --no-transfer-progress -B package -DskipTests --file pom.xml
```
link til commit: [f46277](https://github.com/Sakelig/PGR301-Exam-2022/commit/f46277b90a8e2976e1511b01fcda18a12a7786aa)


## Del 4 - Metrics, overvåkning og alarmer


## Del 5 - Terraform og CloudWatch Dashboards

