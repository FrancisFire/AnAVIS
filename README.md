<p align="center">
  <img src="Frontend/android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png" style="max-width: 20%">
</p>

---

<p align="center">
<img src="https://forthebadge.com/images/badges/made-with-java.svg"/>
<img src="https://forthebadge.com/images/badges/built-for-android.svg"/>
<img src="https://forthebadge.com/images/badges/cc-0.svg"/><br><br>
    <b>AnAVIS</b>, progetto realizzato in <b>Flutter</b> e <b>Spring</b> per il corso di laurea <b>L-31</b> presso <b>Unicam</b>, <i>nell'anno accademico 2019/2020</i>, realizzato dagli studenti Marco Zamponi, Francesco Pio Stelluti e Francesco Coppola per l'esame di <b>Ingegneria del Software</b> seguendo i canoni di sviluppo proposti
    <br><br><b>
<a href="https://www.unicam.it/">• Unicam</a>
<a href="https://avis.it">• AVIS</a>
<a href="https://it.wikipedia.org/wiki/Licenza_MIT">• Licenza</a>
<a href="https://github.com">• <img src="https://github.com/FrancisFire/AnAVIS/workflows/Spring%20Boot%20Test/badge.svg"></img></a>
</b></p>

# Tabella dei contenuti

- [Panoramica](#panoramica)
- [Tecnologie di base](#tecno)
- [Storico incontri e date di consegna](#history)
- [Autori](#autori)

# Panoramica e funzionalità di base <a name = "panoramica"></a>

**Il fine dell'applicativo proposto è quello di automatizzare le comunicazioni tra cittadini e sedi AVIS relative alle prenotazioni di donazioni di sangue. Al momento del rilascio, il software presenta una versione semplificata di quella che è la vera interazione tra cittadini e sedi e si focalizza esclusivamente sulla gestione delle prenotazioni per le donazioni di sangue intero.**

Gli utenti a cui è rivolto l'applicativo sono i cittadini donatori di sangue, gli addetti dell'ufficio AVIS delegati per il suo utilizzo e l'amministratore di sistema. 

Il funzionamento di base del sistema si fonda sulla possibilità per ogni donatore di poter effettuare una **richiesta** per una donazione, se e solo se risulta abilitato a poter donare, presso una specifica sede/ufficio AVIS negli **orari** i cui addetti hanno indicato come utili per poter donare. Nello specifico, per ogni orario, l'addetto dell'ufficio AVIS deve indicare quanti donatori è possibile accogliere per le operazioni di prelievo del sangue contemporaneamente. Al momento della richiesta per una donazione di sangue, l'utente donatore potrà scegliere soltanto tra gli orari che presentino ancora posti disponibili per poter donare. 

Una volta ricevuta una richiesta di donazione presso il proprio ufficio, sta all'addetto AVIS autenticato accettare o meno tale richiesta per farla diventare a tutti gli effetti una **prenotazione**, annullabile in qualsiasi momento sia da parte degli utenti autenticati all'applicativo come donatori che come addetti di un ufficio AVIS. 

Una prenotazione può essere infine conclusa, a segnalazione che la **donazione** di sangue è stata correttamente effettuata e che è ufficialmente disponibile per l'utente donatore coinvolto il **referto** associato alle analisi del sangue prelevato, reso disponibile tramite caricamento diretto nell'applicativo da parte dell'addetto preposto dell'ufficio AVIS presso cui la richiesta di donazione originale è stata effettuata.
La chiusura di una prenotazione coincide anche con l'aggiornamento per il donatore coinvolto circa la sua possibilità di donare, che verrà aggiornata quotidianamente in base alla sua ultima donazione effettuata e in base al suo sesso e, in caso sia di sesso femminile, alla sua fertilità. I dati relativi alle donazioni effettuate in passato da parte di un donatore sono sempre disponibili a quest'ultimo. 

L'**iscrizione** diretta al servizio è resa disponibile esclusivamente agli utenti donatori di sangue. Per quanto concerne l'accesso al servizio da parte degli addetti AVIS delegati per il suo utilizzo si è deciso di rendere la loro iscrizione al servizio una funzionalità esclusiva dell'utente **amministratore** del sistema, alla quale è possibile accedere tramite specifiche credenziali. All'utente amministratore è inoltre riservata la possibilità di eliminare e modificare, nello specifico per quanto riguarda la password di accesso, le credenziali di accesso di tutti gli utenti registrati al sistema. La cancellazione delle credenziali relative ad un utente, sia esso donatore di sangue o addetto preposto di una sede AVIS, non coincide con l'eliminazione delle informazioni relative a tali utente dal sistema, come possono essere le donazioni effettuate, nel caso del donatore, o il set di date utili per una donazione, nel caso dell'addetto AVIS.

# Tecnologie di base<a name = "tecno"></a>

Il lato backend si basa sul linguaggio **Java** e rende disponibile per l'interazione delle **Api Rest**, la cui scrittura e gestione, anche sotto l'ottica della sicurezza, sono state rese possibili grazie al framework **Spring Boot**. Per il testing del codice scritto ci si è affidati al framework **JUnit** mentre per il building automatizzato del sistema si è impiegato il tool **Gradle**. Infine, per poter rendere più agevole la scrittura del codice tramite l'uso di annotazioni, si è deciso di impiegare la libreria Java **Lombok**.

Per quanto concerne la persistenza delle informazioni processate a livello di backend si è deciso di sfruttare i servizi offerti da **MongoDB** e dal relativo framework per linguaggio Java.

Il frontend è interamente scritto in **Dart** e si sostanzia in un applicativo disponibile per tutti i dispositivi con sistema operativo **Android** superiore alla versione 4.4 (KitKat). Nella scrittura dell'applicativo ci si è basati totalmente al framework **Flutter**, che interagisce con il backend tramite chiamate HTTP alle Api Rest rese disponibili. 

# Storico incontri e date di consegna <a name="history"></a>

È possibile controllare lo storico degli incontri del team **Программная инженерия** mediante il [file](https://docs.google.com/document/d/1HMiIRdHMAMtNOgoLFl8B7xCcTn9bTPi2uBCD9vcceFk/edit?usp=sharing) qui allegato.

Le **date di consegna** possono essere consultate seguendo la seguente tabella:

| Numero iterazione |    Data    | Settimana di consegna |
| :---------------: | :--------: | :-------------------: |
|        1°         | 30/11/2019 |         Prima         |
|        2°         | 14/12/2019 |         Terza         |
|        3°         | 04/01/2020 |         Sesta         |
|        4°         | 18/01/2020 |        Ottava         |
|        5°         | 01/02/2020 |        Decima         |

# Autori <a name = "autori"></a>

- [Francesco Coppola](https://github.com/azzeccagarbugli)
- [Francesco Pio Stelluti](https://github.com/FrancisFire)
- [Marco Zamponi](https://github.com/ZamponiMarco)
