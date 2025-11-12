Analiza średnich cen produktów w bazie danych (Northwind)

Treść zadania: Pokaż nazwy kategorii, dla których średnia cena produktów jest wyższa niż średnia cena wszystkich produktów w bazie northwind. Dodaj status wartości produktu (expensive, normal, cheap) oraz dzisiejszą datę.

W zadaniu zostały użyte tabele:
`Products ` 
`Categories  `

Oraz techniki:

-`INNER JOIN` do połączenia tabel Products i Categories,  
-` AVG() `do obliczenia średniej ceny jednostkowej produktów w każdej kategorii,  
-` GROUP BY `do grupowania wyników według kategorii,  
-` HAVING `do porównania średnich cen z globalną średnią wszystkich produktów,  
-`CASE `do klasyfikacji kategorii jako Expensive, Normal lub Cheap,  
-` CAST(GETDATE() AS DATE)` do pobrania bieżącej daty bez czasu,  
-` ORDER BY` do posortowania wyników malejąco według średniej ceny.  

Rezultat zapisanego kodu  
Zapytanie zwraca listę kategorii wraz z ich średnią ceną jednostkową, statusem wartości produktu oraz aktualną datą wykonania analizy.  
Wyniki są posortowane od najwyższej do najniższej średniej ceny produktów.

Projekt SQL wykonany jako część portfolio analityka danych.  
Autor: Piotr Leja
