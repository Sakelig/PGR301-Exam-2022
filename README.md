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


### Oppgave 3
For at sensor skal få sin fork  til å laste opp container image til sitt 
eget ECR repo må det først bli laget et privat ECR repository i AWS, så må man 
sette opp tre nye Github Repository secrets.

ECR repository:
I AWS miljøet søk "Elastic Container Registry" i søke feltet på toppen og 
trykk på den. Deretter trykk "Create repository" > sjekk at settings er satt 
til Private og skriv inn navn på repository. Tilslutt scroll ned og trykk 
"Create repository".

Github Repository secrets:
En kalt "AWS_ACCESS_KEY_ID" og en anne kalt "AWS_SECRET_ACCESS_KEY". 
Disse kan man finne i sitt aws miljø ved å trykke Øverst til høyre der brukernavnet 
står > "Security Credentials" > under "Access keys for CLI, SDK, & API 
access" trykk "Create access key" 
Link til samme sted: [Trykk her hvis du er allerede pålogget :)](https://us-east-1.console.aws.amazon.com/iam/home?region=eu-west-1#/security_credentials)

Den siste secreten som må bli lagt til for å gjøre ting litt lettere er 
"ECR_REPOSITORY_NAME" denne skal ha en verdi som er navnet på ECR 
repositoriet du lagde.
(Da skal du få slippe å endre på docker.yml filen)

## Del 4 - Metrics, overvåkning og alarmer


## Del 5 - Terraform og CloudWatch Dashboards

### Oppgave 1
Forklar med egne ord. Hva er årsaken til dette problemet? Hvorfor forsøker Terraform å opprette en bucket, når den allerede eksisterer?
- Det er fordi den ikke finner state filen og prøver da og lage en ny en i 
  en s3 bucket, men det navnet på S3 bucketen den prøver å lage finnes allerede.

Gjør nødvendige Endre slik denne slik at Terraform kan kjøres flere ganger uten å forsøke å opprette ressurser hver gang den kjører
- Jeg la til dette i provider.tf
```
  backend "s3" {
    bucket = "analytics-1048"
    key    = "1048/terraform.state"
    region = "eu-west-1"
  }
```

Slik at den skulle bruke resource bucker som hadde samme navn og så kjørte jeg denne commandoen en gang:

`terraform import 'aws_s3_bucket.analyticsbucket' 'analytics-1048'`

Så funket det hvergang etter det da den da oppdaterte terraform filen til å skjønne at det var samme bucket så den ikke trengte å lage en ny hvis den allerede fantes


### Oppgave 2
Se `cloudwatch_dashboard.yml` filen for siste version. Den skal nå kjøre apply når det blir pushet mot main branch og plan når det lages en pull request.