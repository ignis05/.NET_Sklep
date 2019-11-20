# as-webforms-sklep

Sklep internetowy wykorzystaniem najnowszych technologii

## <u>**_na 22 listopada_**</u>

## Podział stron (wstępna koncepcja):
### - panel administaracyjny:
- [x] dostępny po zalogowaniu na konto z uprawnieniami
- [ ] zarządzanie zakupami i statusem zamówień
- [ ] zarządzanie użytkownikami (nadawanie statusu admina, usuwanie kont)
### - strona z logowaniem / rejestracją:
- [x] możliwość utworzenia konta lub zalogowania się na istniejące
- [ ] (???) mail aktywacyjny przy tworzeniu konta
### - strona główna
- [ ] linki do logowania, koszyka i jeśli zalogowano na admina panelu administracyjnego
- [ ] lista produktów z opisami
- [ ] wyszukiwanie produktów (<u>??? filtrowanie ???</u>)
- [ ] <b><u>??? dodawanie do koszyka prosto z listy, czy osobna podstrona dla produktu ???</u></b>
### - koszyk
- [ ] ma działać bez i z logowaniem (<u>??? chyba może być całkowicie client-sided ???</u>)
- [ ] wyświetlenie dodanych do koszyka produktów, możliwośc usunięcia / zmiany ilości
- [ ] zatwierdzenie zamówienia - powiadomienie email
s
<hr>
rejestracja i logowanie użytkowników (mail aktywacyjny?)

2 typy użytkowników - zwykły i admin

admin może:
	- zarządzać zakupami (zmieniać status)
	- zarządzać użytkownikami (dawać im admina)
	- usuwać użytkowników
	
koszyk użytkownika

(entity framework?)
[baza ADO.NET (mniej punktów) LUB baza MySQL]
