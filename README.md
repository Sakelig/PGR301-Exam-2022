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


### Oppgave 2 ** TESTING NEEDED IN THE END **
CI workflowen kjører nå på hver eneste push, uavhengig av branch **TEST THIS WITH DUMMY USER**
etter å ha fått "Build with Maven" jobben til å kjøre med dette:
```
 - name: Build with Maven
        run: mvn -B package --file pom.xml
```
Så istedenfor å bare compilere, vil den nå kjøre testene før den blir pakke.


### Oppgave 3
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
Slik at kode some merges til main blir verifisert av Github Actions ved å kjøre workflow actions og passerer 
 
[insert bilde av settings side med branches valgt og sånt]



##Del 3 - Docker


##Del 4 - Metrics, overvåkning og alarmer


##Del 5 - Terraform og CloudWatch Dashboards

