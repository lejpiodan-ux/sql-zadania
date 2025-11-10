Analiza produktów o niskiej częstotliwości zamówień  Ogólnodostępnej bazy danych (Northwind)

Cel analizy
Celem tego zapytania było znalezienie produktów, które sprzedają się rzadziej niż średnia liczba zamówień wszystkich produktów, a następnie zidentyfikowanie klientów, którzy je kupują.

Opis rozwiązania
W zapytaniu wykorzystano tabele:
- `Products`
- `Order Details`
- `Orders`
- `Customers`

Oraz techniki:
- `INNER JOIN` do połączenia danych,
- `COUNT()` i `AVG()` do obliczeń agregujących,
- podzapytanie (`subquery`) w klauzuli `HAVING`,  
- sortowanie wyników malejąco po liczbie zamówień.
- `OFFSET` i `FETCH` do paginacji.   

Rezultat zapisanego kodu
Zapytanie zwraca listę 100 produktów i klientów, którzy kupują towary zamawiane |rzadziej| niż średnia liczba zamówień w całej bazie.



Projekt SQL wykonany jako część portfolio analityka danych.  
Autor: Piotr Leja
