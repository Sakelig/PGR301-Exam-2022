# PGR301 Eksamen 1048

[![Ci pipeline](https://github.com/Sakelig/PGR301-Exam-2022/actions/workflows/ci.yml/badge.svg)](https://github.com/Sakelig/PGR301-Exam-2022/actions/workflows/ci.yml)
[![Docker build](https://github.com/Sakelig/PGR301-Exam-2022/actions/workflows/docker.yml/badge.svg)](https://github.com/Sakelig/PGR301-Exam-2022/actions/workflows/docker.yml)
[![Terraform CloudWatch](https://github.com/Sakelig/PGR301-Exam-2022/actions/workflows/cloudwatch_dashboard.yml/badge.svg)](https://github.com/Sakelig/PGR301-Exam-2022/actions/workflows/cloudwatch_dashboard.yml)

## Del 1 - DevOps-prinsipper
### Hva er utfordringene med dagens systemutviklingsprosess - og hvordan vil innføring av DevOps kunne være med på å løse disse? Hvilke DevOps prinsipper blir brutt?
- Et av utfordringene nå er at det er altfor få releaser altså lav *deployment frequency*. Innføring av DevOps vil kunne øke releaser fra 4 ganger i året til flere titals daglig da veien fra kode til produksjon blir kortere som vil minske *lead time for changes*. Dette vil være en god ting for utviklerne da man kan enklere jobbe med mindre oppgaver og release hyppiger. Det vil også være en god ting for buisness da man kan endre koden raskere gjør at vi kan lære ting raskere og få *feedback* kjappere.
Et av hoved prinsippene i DevOps som blir brutt er da flyt, som igjen fører til andre underprinsipper blir brutt.
- En annen utfording er at deployment ofte feiler som er høy *Change failure rate* eller fører til ustabilitet som da fører til at de rollbacker til forrgie version som forsinker ny funksjonalitet gir dem en lav *Mean time to recovery*. DevOps vil minske sjansene for at koden feiler eller er ustabil før den blir pushed til produksjons koden, og vil være med på å fjerne *waste* som da har oppstått pga av det. Et annet hovedprinsipp som blir brutt her er da feedback, da det tar for lang tid før en får tilbake melding på at noe ikke stemmer og det skjer altfor sent i prossesen.
- En utfording til er at det ikke er samme team som håndtere drift- og utvikling, det blir da skapt en form for flaske hals mellom teamene da de alltid er avhengig av hverandre. Devops vil fjerne denne falske halsen da den er med på å skape *waste* i begge teamene.


### En vanlig respons på mange feil under release av ny funksjonalitet er å gjøre det mindre hyppig, og samtidig forsøke å legge på mer kontroll og QA. Hva er problemet med dette ut ifra et DevOps perspektiv, og hva kan være en bedre tilnærming?
- Problemet er at dette skaper lav *deployment frequency*. En bedre tilnærming vil være å lage en bedre utviklingsflyt der man får *feedback* tidlig i utviklingen med automatiske tester der koden blir testet før den kommer i produksjon. Dette kan bli gjort med f.eks. branch protection der workflows må kjøres og godkjenne koden før den f.eks. skal merges :)


### Teamet overleverer kode til en annen avdeling som har ansvar for drift - hva er utfordringen med dette ut ifra et DevOps perspektiv, og hvilke gevinster kan man få ved at team han ansvar for både drift- og utvikling?
- Utfordinger dette skaper er at begge teamene er alltid avhengig av det andre og dette skaper *waste*. Når et team må vente på at et annet skal levere kode som skal til prod så er det lang vei tilbake igjen hvis noe er galt med den. Dette vil også være med på å gi dem en lavere *Mean time to recovery* da veien til prod for utviklenre er lengre, og det vil da ta lengre tid å fikse det. Gevinstene man kan få ved at et team har ansvar for både drift- og utvikling er mindre *waste* altså bortkaste prosseser som tar tid og høyere *mean time to recovery* da veien til prod å fikse noe vil være kortere.


### Å release kode ofte kan også by på utfordringer. Beskriv hvilke- og hvordan vi kan bruke DevOps prinsipper til å redusere eller fjerne risiko ved hyppige leveraner.
- For å redusere risiko på leveranse kan vi sette inn *metrics* for å måle hvor feil kan oppstå før den faktisk gjør det, dette vil redusere *Change failure rate*-en som er en good ting.
- Sette opp CI/CD vil også være gunstig da man kan lettere få kode til prod oftere og man kan på den måten gjøre mindre av gangen. Det vil da være enklere å finne ut av hvilken del av den ny funksjonaliteten failer eller mangler da man vil fort få tilbake melding på det uten å ha skrevet ferdig alt av kode for å så vite at man ikke kan gjøre noe på en uttenkt måte pga en feil tidlig.

 

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


### Oppgave 2
CI workflowen kjører nå på hver eneste push, uavhengig av branch **TEST THIS WITH DUMMY USER**
etter å ha fått "Build with Maven" jobben til å kjøre med dette:
```
 - name: Build with Maven
        run: mvn -B package --file pom.xml
```
Så istedenfor å bare compilere, vil den nå kjøre testene før den blir pakke.


### Oppgave 3
Sensor må gå inn i settings i repoet:
![DEL2_OPPGAVE3_BILDE2](https://user-images.githubusercontent.com/71970061/205299668-47e230d4-6f5c-4df2-81c2-7f36168ce1b2.PNG)

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

![DEL2_OPPGAVE3_BILDE](https://user-images.githubusercontent.com/71970061/205299230-b7453b6a-ae99-4770-9661-4789355a7181.PNG)



## Del 3 - Docker

### Oppgave 1
For å få workflowen til å fungere med DockerHub kontoen min må jeg legge til 
secrets i repoet i Github, da workflown spesifikt ser etter en sercet som 
heter "DOCKER_HUB_USERNAME" og "DOCKER_HUB_TOKEN".
Den failer og får "Error: Username and password required" da den ikke 
har en username og passord å skrive inn.

![DEL3_OPPGAVE1_BILDE](https://user-images.githubusercontent.com/71970061/205299087-e3a59a7a-9ae0-4413-9a7f-73d2ec4ec3cb.PNG)


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
Disse cookie verdiene kan man finne i sitt aws miljø ved å trykke Øverst til 
høyre der brukernavnet står > "Security Credentials" > under "Access keys for CLI, SDK, & API 
access" trykk "Create access key" 
Link til samme sted: [Trykk her hvis du er allerede pålogget :)](https://us-east-1.console.aws.amazon.com/iam/home?region=eu-west-1#/security_credentials)

Den siste secreten som må bli lagt til for å gjøre ting litt lettere er 
"ECR_REPOSITORY_NAME" denne skal ha en verdi som er navnet på ECR 
repositoriet du lagde.
(Da skal du få slippe å endre på docker.yml filen)



## Del 4 - Metrics, overvåkning og alarmer

### Oppgave 1
Den skal bare trenge 
```
<dependency>
    <groupId>io.micrometer</groupId>
    <artifactId>micrometer-registry-cloudwatch2</artifactId>
</dependency>

<dependency>
    <groupId>io.micrometer</groupId>
    <artifactId>micrometer-core</artifactId>
</dependency>
```
i `pom.xml` i det minste for å kunne sende noe data til CloudWatch, samt 
`MetricsConfig` som forteller hvor og hvem den skal sende dataen til og `TimedConfig` for å kunne bruke @Timed
annotation til å rapportere tid en method har brukt.


### Oppgave 2
Se `ShoppingCartController` filen for endringer gjort slik at datan blir 
rapportert til Cloudwatch



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


### Oppgave 3
Se `dashboard.tf` filen for hvordan alle de 4 metricsene blir laget. 
NB! Kan være vanskelig å se antall handlevogner siden det er per time så du burde endre periode til noe kortere hvis du faktisk vil se uten å måtte vente lenge. 

### Alarmer
Se `sns_topic_for_alarm.tf` filen for hvordan alt med alarmen er satt og selve alarmen selv.
