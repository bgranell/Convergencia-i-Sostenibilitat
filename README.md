# Convergència i Sostenibilitat
## Descomposició de la dinàmica de les emissions de gasos d'efecte hivernacle (GEH).
TFG titulat "Convergència i Sostenibilitat" i tutoritzat pel reconegut economista català Albert Carreras de Odriozola. Puntuat amb un 9,5.

Davant de la pregunta ¿Quin impacte tindria en les emissions de GEH globals la efectiva convergència dels països en vies de desenvolupament i subdesenvolupats a nivells del primer món?, vaig fer una regressió lineal per cada país d'interès del seu històric d'emissions al llarg de 50 anys amb el seu PIBpc, amb correlacions de vora el 97-98%.
Calculant taxes d'increment del PIBpc mitjanes dels últims 15 anys d'ençà de la última observació disponible (2003-2018), vaig fer projeccions a 12 anys en el futur del PIB/pc amb l'increment associat de les emissions, per cada país.

Per a construir el marc teòric em vaig basar amb informació de l'IPCC i vaig conformar les meves pròpies dades en relació al PIB, emissions per càpita, emissions per unitat de PIBpc, etc., i trastejant amb números de les emissions anuals per països, vaig adonar-me que la suma de dos columnes resultava en una tercera columna ja existent. En aquest moment el meu treball de final de grau va prendre una altra dimensió encara més interessant que la original.

$$ Emissions = PIBpc * Emissions/PIBpc $$

El descobriment va resultar bastant evident quan vaig acabar d'entendre'l, i es que la taxa d'increment de les emissions és igual a la suma de la taxa d'increment del PIBpc i la taxa d'increment de la intensitat d'emissió per cada unitat de PIBpc. Havia fet un raonament primitiu que ja va fer Yoichi Kaya l'any 1993, creant la identitat de Kaya:

$$ Emissions = Població * PIB/Població * Energia/PIB * CO2/Energia $$

D'aquesta manera, i amb el coneixement de que alguns països ja van establir el seu màxim anual d'emissions vora l'any 2003 i que alguns encara baten el seu màxim d'emissions any rere any, vaig veure que la causa no era que aquests últims no fessin tants esforços com els primers en millores d'eficiència de les emissions per unitat de PIBpc, sinó que aquest increment de l'eficiència es veia engolit per un increment més gran en PIBpc, ***fent perfectament compatible ser més eficient amb contaminar més***.

