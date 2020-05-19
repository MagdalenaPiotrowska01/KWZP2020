USE szwalnia
GO

---- Widok cech elementu
CREATE VIEW [dbo].[vCechyElementu]
AS
SELECT Elementy.ID_Element,Cecha, Wartosc_Cechy_Liczbowa, Jednostka, Wartosc_Cechy_Slowna 
FROM Elementy INNER JOIN 
	Elementy_Cechy ON Elementy.ID_Element = Elementy_Cechy.ID_Element INNER JOIN 
	Elementy_Cechy_Slownik ON Elementy_Cechy.ID_Cecha = Elementy_Cechy_Slownik.ID_Cecha INNER JOIN 
	Elementy_Jednostki ON Elementy_Cechy.ID_Jednostka = Elementy_Jednostki.ID_jednostka
GO

---- Widok polek na regalach (z wymiarami)
CREATE VIEW [dbo].[vPolki_na_regalach]
AS
SELECT        TOP (100) PERCENT dbo.Regaly.Oznaczenie, dbo.Polki.ID_Polka, dbo.Polki_Rozmiary.Wysokosc, dbo.Polki_Rozmiary.Szerokosc, dbo.Polki_Rozmiary.Glebokosc, CAST(dbo.Polki_Rozmiary.Wysokosc AS NVARCHAR) 
                         + ' x ' + CAST(dbo.Polki_Rozmiary.Szerokosc AS NVARCHAR) + ' x ' + CAST(dbo.Polki_Rozmiary.Glebokosc AS NVARCHAR) + ' cm' AS Wymiar, '      ' AS [Stan]
FROM            dbo.Regaly INNER JOIN
                         dbo.Polki_regaly ON dbo.Regaly.ID_regal = dbo.Polki_regaly.ID_regal INNER JOIN
                         dbo.Polki ON dbo.Polki_regaly.ID_Polka = dbo.Polki.ID_Polka INNER JOIN
                         dbo.Polki_Rozmiary ON dbo.Polki.ID_Rozmiar_Polki = dbo.Polki_Rozmiary.ID_Rozmiar_Polki
ORDER BY dbo.Polki.ID_Polka
GO

---- Widok rozmiarow polek (posegregowane po wymiarach)
CREATE VIEW [dbo].[vPolki_Rozmiary]
AS
SELECT        TOP (100) PERCENT ID_Rozmiar_Polki, Wysokosc, Szerokosc, Glebokosc, CAST(dbo.Polki_Rozmiary.Wysokosc AS NVARCHAR) 
                         + ' x ' + CAST(dbo.Polki_Rozmiary.Szerokosc AS NVARCHAR) + ' x ' + CAST(dbo.Polki_Rozmiary.Glebokosc AS NVARCHAR) AS Wymiar
FROM            dbo.Polki_Rozmiary
ORDER BY Wysokosc, Szerokosc, Glebokosc
GO

---- Widok zawartosci polek
CREATE VIEW [dbo].[vZawartosc_polki]
AS
SELECT         dbo.Zawartosc.ID_Zawartosc, dbo.Zawartosc.ID_Polka, dbo.Elementy.Element_Nazwa, dbo.Oferta.ID_Element, dbo.Oferta.Ilosc_W_Opakowaniu_Pojedynczym * dbo.Zawartosc.Ilosc_Paczek AS Ile, dbo.Elementy_Jednostki.Jednostka, 
                         dbo.Zamowienia_Dostawy.Data_Dostawy_Rzeczywista, dbo.Elementy.Okres_Przydatnosci_Miesiace
FROM            dbo.Zawartosc INNER JOIN
                         dbo.Elementy ON dbo.Zawartosc.ID_Element = dbo.Elementy.ID_Element INNER JOIN
                         dbo.Oferta ON dbo.Elementy.ID_Element = dbo.Oferta.ID_Element INNER JOIN
                         dbo.Dostawy_Zawartosc ON dbo.Elementy.ID_Element = dbo.Dostawy_Zawartosc.ID_Element AND dbo.Oferta.ID_Oferta = dbo.Dostawy_Zawartosc.ID_oferta INNER JOIN
                         dbo.Zamowienia_Dostawy ON dbo.Zawartosc.ID_Dostawy = dbo.Zamowienia_Dostawy.ID_Dostawy AND dbo.Dostawy_Zawartosc.ID_Dostawy = dbo.Zamowienia_Dostawy.ID_Dostawy INNER JOIN
                         dbo.Elementy_Jednostki ON dbo.Oferta.ID_Jednostka = dbo.Elementy_Jednostki.ID_jednostka
GO

-- Widok oznacze� rega��w alfabetycznie
CREATE VIEW [dbo].[vRegaly_alfabetycznie]
AS
SELECT        TOP (100) PERCENT ID_regal, Oznaczenie
FROM            dbo.Regaly
ORDER BY Oznaczenie
GO
-- Widok podsumowujacy materialy z magazynu ktore zostaly przypisane do zamowien
CREATE VIEW [dbo].[vMaterialyZMagazynu]
AS
SELECT        dbo.Dostawy_Wlasne_Zawartosc.ID_Dostawy, dbo.Zamowienia_Dostawy_Wlasne.ID_Zamowienia, dbo.Dostawy_Wlasne_Zawartosc.ID_Element, SUM(dbo.Dostawy_Wlasne_Zawartosc.Ilosc) * - 1 AS Ilosc
FROM            dbo.Dostawy_Wlasne_Zawartosc INNER JOIN
                         dbo.Zamowienia_Dostawy_Wlasne ON dbo.Dostawy_Wlasne_Zawartosc.ID_Zamowienia_dostawy_wlasne = dbo.Zamowienia_Dostawy_Wlasne.ID_Zamowienia_dostawy_wlasne
GROUP BY dbo.Zamowienia_Dostawy_Wlasne.ID_Zamowienia, dbo.Dostawy_Wlasne_Zawartosc.ID_Element, dbo.Dostawy_Wlasne_Zawartosc.ID_Dostawy
GO
--Widok podsumowujacy materialy potrzebne do wykonania zamowienia
CREATE VIEW [dbo].[vMaterialyDoZamowienia]
AS
SELECT        dbo.Zamowienia.ID_Zamowienia, dbo.Elementy_Proces.ID_Element, SUM(dbo.Elementy_Proces.Liczba) AS Ilosc
FROM            dbo.Proces_Technologiczny INNER JOIN
                         dbo.Elementy_Proces ON dbo.Proces_Technologiczny.ID_Proces_Technologiczny = dbo.Elementy_Proces.ID_Proces_Technologiczny INNER JOIN
                         dbo.Proces_Zamowienie ON dbo.Proces_Technologiczny.ID_Proces_Technologiczny = dbo.Proces_Zamowienie.ID_Proces_Technologiczny INNER JOIN
                         dbo.Zamowienia INNER JOIN
                         dbo.Zamowienie_Element ON dbo.Zamowienia.ID_Zamowienia = dbo.Zamowienie_Element.ID_Zamowienia ON dbo.Proces_Zamowienie.ID_Zamowienie_Element = dbo.Zamowienie_Element.ID_Zamowienie_Element
WHERE        (dbo.Proces_Zamowienie.Kompletny_Proces = 1)
GROUP BY dbo.Zamowienia.ID_Zamowienia, dbo.Elementy_Proces.ID_Element
GO
--Widok podsumowujacy juz zamowione materialy
CREATE VIEW [dbo].[vMaterialyZamowione]
AS
SELECT        dbo.Zamowienia_Dostawy.ID_Dostawy, dbo.Zamowienia_Dostawy.ID_Zamowienia, dbo.Dostawy_Zawartosc.ID_Element, 
                         dbo.Dostawy_Zawartosc.Ilosc_Dostarczona * dbo.Oferta.Ilosc_W_Opakowaniu_Pojedynczym * - 1 AS Ilosc
FROM            dbo.Zamowienia_Dostawy INNER JOIN
                         dbo.Dostawy_Zawartosc ON dbo.Zamowienia_Dostawy.ID_Dostawy = dbo.Dostawy_Zawartosc.ID_Dostawy INNER JOIN
                         dbo.Oferta ON dbo.Dostawy_Zawartosc.ID_oferta = dbo.Oferta.ID_Oferta
WHERE        (dbo.Zamowienia_Dostawy.ID_statusu IS NOT NULL)
GO
--Widok podsumowujacy materialy brakujace ktore trzeba domowic
CREATE VIEW [dbo].[vMaterialyDoZamowieniaBrak]
AS
SELECT        Wszystko.ID_Zamowienia, dbo.Elementy.ID_Element, dbo.Elementy.Element_Nazwa, SUM(Wszystko.Ilosc) AS Ilosc
FROM            (SELECT        ID_Zamowienia, ID_Element, Ilosc
                          FROM            dbo.vMaterialyDoZamowienia
                          UNION ALL
                          SELECT        ID_Zamowienia, ID_Element, Ilosc
                          FROM            dbo.vMaterialyZamowione
                          UNION ALL
                          SELECT        ID_Zamowienia, ID_Element, Ilosc
                          FROM            dbo.vMaterialyZMagazynu) AS Wszystko INNER JOIN
                         dbo.Elementy ON Wszystko.ID_Element = dbo.Elementy.ID_Element
GROUP BY Wszystko.ID_Zamowienia, dbo.Elementy.Element_Nazwa, dbo.Elementy.ID_Element
HAVING        (SUM(Wszystko.Ilosc) > 0)
GO

--widok ofert
CREATE VIEW [dbo].[vOferta]
AS
SELECT        dbo.Oferta.ID_Element, dbo.Oferta.ID_Oferta, dbo.Dostawcy_Zaopatrzenie.ID_Dostawcy, dbo.Oferta.Element_Oznaczenie, CAST(dbo.Oferta.Cena_Jedn AS DECIMAL(18, 2)) AS Cena_Jedn, 
                         dbo.Oferta.Ilosc_W_Opakowaniu_Pojedynczym, dbo.Oferta.Deklarowany_czas_dostawy, dbo.Dostawcy_Zaopatrzenie.Nazwa, dbo.Oferta.Ilosc_Minimalna, dbo.Oferta.Ilosc_Maksymalna, 
                         dbo.Dostawcy_Zaopatrzenie.Telefon_1
FROM            dbo.Oferta INNER JOIN
                         dbo.Dostawcy_Zaopatrzenie ON dbo.Oferta.ID_Dostawcy = dbo.Dostawcy_Zaopatrzenie.ID_Dostawcy
GROUP BY dbo.Oferta.ID_Element, dbo.Oferta.ID_Oferta, dbo.Oferta.Element_Oznaczenie, dbo.Oferta.Cena_Jedn, dbo.Oferta.Ilosc_W_Opakowaniu_Pojedynczym, dbo.Dostawcy_Zaopatrzenie.ID_Dostawcy, 
                         dbo.Dostawcy_Zaopatrzenie.Nazwa, dbo.Dostawcy_Zaopatrzenie.Telefon_1, dbo.Oferta.Ilosc_Minimalna, dbo.Oferta.Ilosc_Maksymalna, dbo.Oferta.Deklarowany_czas_dostawy
GO

--widok zawartosci magazynu do przydzia�u do zamowien
CREATE VIEW [dbo].[vZawartoscMagazynuDoPrzydzialu]
AS
SELECT        dbo.Polki.ID_Polka, dbo.Zawartosc.ID_Element, dbo.Zawartosc.ID_Dostawy, dbo.Oferta.Element_Oznaczenie, dbo.Zawartosc.Ilosc_Paczek * dbo.Oferta.Ilosc_W_Opakowaniu_Pojedynczym AS Ilosc, 
                         CAST(dbo.Oferta.Cena_Jedn AS DECIMAL(18, 2)) AS Cena
FROM            dbo.Zawartosc INNER JOIN
                         dbo.Zamowienia_Dostawy ON dbo.Zawartosc.ID_Dostawy = dbo.Zamowienia_Dostawy.ID_Dostawy INNER JOIN
                         dbo.Dostawy_Zawartosc ON dbo.Zamowienia_Dostawy.ID_Dostawy = dbo.Dostawy_Zawartosc.ID_Dostawy INNER JOIN
                         dbo.Oferta ON dbo.Dostawy_Zawartosc.ID_oferta = dbo.Oferta.ID_Oferta INNER JOIN
                         dbo.Polki ON dbo.Zawartosc.ID_Polka = dbo.Polki.ID_Polka
GO

--widok pokazuj�cy od kogo jest kt�ra dostawa i do kt�rego zam�wienia
CREATE VIEW [dbo].[vDostawcyDostawDoZamowien]
AS
SELECT        dbo.Zamowienia_Dostawy.ID_Zamowienia, dbo.Zamowienia_Dostawy.ID_Dostawy, dbo.Oferta.ID_Dostawcy, dbo.Zamowienia_Dostawy.ID_statusu
FROM            dbo.Zamowienia_Dostawy INNER JOIN
                         dbo.Dostawy_Zawartosc ON dbo.Zamowienia_Dostawy.ID_Dostawy = dbo.Dostawy_Zawartosc.ID_Dostawy INNER JOIN
                         dbo.Oferta ON dbo.Dostawy_Zawartosc.ID_oferta = dbo.Oferta.ID_Oferta
WHERE        (dbo.Zamowienia_Dostawy.ID_statusu <> 3)
GO
--lista dostaw do przyjecia
CREATE VIEW [dbo].[vDostawyDoOdbioru]
AS
SELECT        dbo.Zamowienia_Dostawy.ID_Dostawy, dbo.Dostawy_Zawartosc.ID_Element, dbo.Oferta.Ilosc_W_Opakowaniu_Pojedynczym AS Ilosc_w_paczce, 
                         dbo.Dostawy_Zawartosc.Ilosc_Dostarczona * dbo.Oferta.Ilosc_W_Opakowaniu_Pojedynczym AS Ilosc
FROM            dbo.Zamowienia_Dostawy INNER JOIN
                         dbo.Dostawy_Zawartosc ON dbo.Zamowienia_Dostawy.ID_Dostawy = dbo.Dostawy_Zawartosc.ID_Dostawy INNER JOIN
                         dbo.Oferta ON dbo.Dostawy_Zawartosc.ID_oferta = dbo.Oferta.ID_Oferta LEFT OUTER JOIN
                             (SELECT        ID_Dostarczenia, ID_Pracownicy, ID_Dostawy, ID_Zamowienie_element, ID_element, Ilosc_Dostarczona, ID_Miejsca, Data_Dostarczenia
                               FROM            dbo.Dostarczenia_Wewn
                               WHERE        (Ilosc_Dostarczona > 0) AND (ID_Miejsca <> 2)) AS Dostarczenia_wewn_select ON dbo.Zamowienia_Dostawy.ID_Dostawy = Dostarczenia_wewn_select.ID_Dostawy
WHERE        (Dostarczenia_wewn_select.ID_Dostawy IS NULL)
GO
--lista wolnych polek
CREATE VIEW [dbo].[vWolnePolki]
AS
SELECT        dbo.Polki.ID_Polka
FROM            dbo.Zawartosc RIGHT OUTER JOIN
                         dbo.Polki ON dbo.Zawartosc.ID_Polka = dbo.Polki.ID_Polka
WHERE        (dbo.Zawartosc.ID_Polka IS NULL)
GO
--lista pracownikow magazynu 
CREATE VIEW [dbo].[vPracownicyMagazynu]
AS
SELECT        dbo.Pracownicy.ID_Pracownika, dbo.Pracownicy.Imie + ' ' + dbo.Pracownicy.Nazwisko AS Dane_osobowe, dbo.Pracownicy_Zatrudnienie.ID_Dzialu
FROM            dbo.Pracownicy INNER JOIN
                         dbo.Pracownicy_Zatrudnienie ON dbo.Pracownicy.ID_Pracownika = dbo.Pracownicy_Zatrudnienie.ID_Pracownika
WHERE        (dbo.Pracownicy_Zatrudnienie.ID_Dzialu = 2)
GO
--widok materia��w dostarczonych na produkcje
CREATE VIEW [dbo].[vDostarczeniaNaProdukcje]
AS
SELECT        ID_Dostarczenia, ID_Pracownicy, ID_Dostawy, ID_Zamowienie_element, ID_element, Ilosc_Dostarczona, ID_Miejsca, Data_Dostarczenia
FROM            dbo.Dostarczenia_Wewn
WHERE        (Ilosc_Dostarczona < 0)
GO
--widok materia��w potrzebnych produkcji
CREATE VIEW [dbo].[vPotrzebyProdukcjiZDatami]
AS
SELECT DISTINCT dbo.Proces_Produkcyjny.ID_Zamowienie_Element, dbo.Elementy_Proces.ID_Element, dbo.Elementy_Proces.Liczba, dbo.Proces_Produkcyjny.Proponowana_data_dostawy_materialu
FROM            dbo.Zamowienie_Element INNER JOIN
                         dbo.Proces_Produkcyjny ON dbo.Zamowienie_Element.ID_Zamowienie_Element = dbo.Proces_Produkcyjny.ID_Zamowienie_Element INNER JOIN
                         dbo.Elementy_Proces INNER JOIN
                         dbo.Proces_Technologiczny ON dbo.Elementy_Proces.ID_Proces_Technologiczny = dbo.Proces_Technologiczny.ID_Proces_Technologiczny INNER JOIN
                         dbo.Proces_Zamowienie ON dbo.Proces_Technologiczny.ID_Proces_Technologiczny = dbo.Proces_Zamowienie.ID_Proces_Technologiczny ON 
                         dbo.Zamowienie_Element.ID_Zamowienie_Element = dbo.Proces_Zamowienie.ID_Zamowienie_Element
GO
--widok materia��w jeszcz nie wydanych a potrzebnych
CREATE VIEW [dbo].[vDostawyDoWydania]
AS
SELECT DISTINCT 
                         dbo.vPotrzebyProdukcjiZDatami.ID_Zamowienie_Element, dbo.vPotrzebyProdukcjiZDatami.ID_Element, dbo.vPotrzebyProdukcjiZDatami.Liczba AS Ilosc, dbo.vPotrzebyProdukcjiZDatami.Proponowana_data_dostawy_materialu, 
                         dbo.Elementy.Element_Nazwa, dbo.Zamowienie_Element.ID_Zamowienia, dbo.vMaterialyZamowione.ID_Dostawy
FROM            dbo.Elementy INNER JOIN
                         dbo.vPotrzebyProdukcjiZDatami INNER JOIN
                         dbo.Zamowienie_Element ON dbo.vPotrzebyProdukcjiZDatami.ID_Zamowienie_Element = dbo.Zamowienie_Element.ID_Zamowienie_Element ON 
                         dbo.Elementy.ID_Element = dbo.vPotrzebyProdukcjiZDatami.ID_Element INNER JOIN
                         dbo.Zamowienia ON dbo.Zamowienie_Element.ID_Zamowienia = dbo.Zamowienia.ID_Zamowienia INNER JOIN
                         dbo.vMaterialyZamowione ON dbo.Zamowienia.ID_Zamowienia = dbo.vMaterialyZamowione.ID_Zamowienia AND dbo.vPotrzebyProdukcjiZDatami.ID_Element = dbo.vMaterialyZamowione.ID_Element LEFT OUTER JOIN
                         dbo.vDostarczeniaNaProdukcje ON dbo.vPotrzebyProdukcjiZDatami.ID_Element = dbo.vDostarczeniaNaProdukcje.ID_element AND 
                         dbo.vPotrzebyProdukcjiZDatami.ID_Zamowienie_Element = dbo.vDostarczeniaNaProdukcje.ID_Zamowienie_element
WHERE        (dbo.vDostarczeniaNaProdukcje.ID_Zamowienie_element IS NULL) AND (dbo.vDostarczeniaNaProdukcje.ID_element IS NULL)
GO
--widok materia��w pozosta�ych po wyprodukowaniu
CREATE VIEW [dbo].[vNiezuzytyMaterialNaProdukcji]
AS
SELECT        dbo.Proces_Produkcyjny.ID_Zamowienie_Element, dbo.Elementy_Proces.ID_Element, SUM(dbo.Material_Na_Produkcji.Niezuzyty_material) AS Niezuzyty_material
FROM            dbo.Material_Na_Produkcji INNER JOIN
                         dbo.Proces_Produkcyjny ON dbo.Material_Na_Produkcji.ID_Procesu_Produkcyjnego = dbo.Proces_Produkcyjny.ID_Procesu_Produkcyjnego INNER JOIN
                         dbo.Elementy_Proces ON dbo.Material_Na_Produkcji.ID_Elementy_Proces = dbo.Elementy_Proces.ID_Elementy_Proces
GROUP BY dbo.Proces_Produkcyjny.ID_Zamowienie_Element, dbo.Elementy_Proces.ID_Element
GO
--widok materia��w ju� odebranych po wyprodukowaniu
CREATE VIEW [dbo].[vMaterialyOdebraneZProdukcji]
AS
SELECT        ID_Dostarczenia, ID_Pracownicy, ID_Dostawy, ID_Zamowienie_element, ID_element, Ilosc_Dostarczona, ID_Miejsca, Data_Dostarczenia
FROM            dbo.Dostarczenia_Wewn
WHERE        (Ilosc_Dostarczona > 0) AND (ID_Miejsca = 2)
GO
--widok materia��w oczekuj�cych na odebranie wg ID_zamowienie_element
CREATE VIEW [dbo].[vNieodebraneMaterialyWgZamowienieElement]
AS
SELECT        dbo.vNiezuzytyMaterialNaProdukcji.ID_Zamowienie_Element, dbo.vNiezuzytyMaterialNaProdukcji.ID_Element, dbo.vNiezuzytyMaterialNaProdukcji.Niezuzyty_material
FROM            dbo.vMaterialyOdebraneZProdukcji RIGHT OUTER JOIN
                         dbo.vNiezuzytyMaterialNaProdukcji ON dbo.vMaterialyOdebraneZProdukcji.ID_Zamowienie_element = dbo.vNiezuzytyMaterialNaProdukcji.ID_Zamowienie_Element AND 
                         dbo.vMaterialyOdebraneZProdukcji.ID_element = dbo.vNiezuzytyMaterialNaProdukcji.ID_Element
WHERE        (dbo.vMaterialyOdebraneZProdukcji.ID_element IS NULL) AND (dbo.vMaterialyOdebraneZProdukcji.ID_Zamowienie_element IS NULL)
GO
--widok materia��w oczekuj�cych na odebranie zawierajacy wszystkie dane
CREATE VIEW [dbo].[vNieodebraneMaterialyWgDostawy]
AS
SELECT        dbo.vNieodebraneMaterialyWgZamowienieElement.ID_Zamowienie_Element, dbo.Zamowienia_Dostawy.ID_Dostawy, dbo.vNieodebraneMaterialyWgZamowienieElement.ID_Element, 
                         dbo.vNieodebraneMaterialyWgZamowienieElement.Niezuzyty_material
FROM            dbo.vNieodebraneMaterialyWgZamowienieElement INNER JOIN
                         dbo.Zamowienie_Element ON dbo.vNieodebraneMaterialyWgZamowienieElement.ID_Zamowienie_Element = dbo.Zamowienie_Element.ID_Zamowienie_Element INNER JOIN
                         dbo.Zamowienia ON dbo.Zamowienie_Element.ID_Zamowienia = dbo.Zamowienia.ID_Zamowienia INNER JOIN
                         dbo.Zamowienia_Dostawy ON dbo.Zamowienia.ID_Zamowienia = dbo.Zamowienia_Dostawy.ID_Zamowienia INNER JOIN
                         dbo.Dostawy_Zawartosc ON dbo.Zamowienia_Dostawy.ID_Dostawy = dbo.Dostawy_Zawartosc.ID_Dostawy 
						 AND dbo.vNieodebraneMaterialyWgZamowienieElement.ID_Element = dbo.Dostawy_Zawartosc.ID_Element
GO
--widok materia��w oczekuj�cych na odebranie zawierajacy wszystkie dane plus nazwe do wyswietlania
CREATE VIEW [dbo].[vNieodebraneMaterialyWgDostawyZNazwa]
AS
SELECT        dbo.vNieodebraneMaterialyWgDostawy.ID_Zamowienie_Element, dbo.vNieodebraneMaterialyWgDostawy.ID_Dostawy, dbo.vNieodebraneMaterialyWgDostawy.ID_Element, dbo.Elementy.Element_Nazwa, 
                         dbo.vNieodebraneMaterialyWgDostawy.Niezuzyty_material
FROM            dbo.Elementy INNER JOIN
                         dbo.vNieodebraneMaterialyWgDostawy ON dbo.Elementy.ID_Element = dbo.vNieodebraneMaterialyWgDostawy.ID_Element
GO
--do [vNieodebraneMaterialyWgDostawyZNazwa] dodano ilosc_w_paczce z Oferta aby liczy� ilo�� paczek
CREATE VIEW [dbo].[vNieodebraneMaterialyWgDostawcyZNazwaIOferta]
AS
SELECT        dbo.vNieodebraneMaterialyWgDostawyZNazwa.ID_Zamowienie_Element, dbo.vNieodebraneMaterialyWgDostawyZNazwa.ID_Dostawy, dbo.vNieodebraneMaterialyWgDostawyZNazwa.ID_Element, 
                         dbo.vNieodebraneMaterialyWgDostawyZNazwa.Element_Nazwa, dbo.vNieodebraneMaterialyWgDostawyZNazwa.Niezuzyty_material, dbo.Oferta.Ilosc_W_Opakowaniu_Pojedynczym
FROM            dbo.Oferta INNER JOIN
                         dbo.Dostawy_Zawartosc ON dbo.Oferta.ID_Oferta = dbo.Dostawy_Zawartosc.ID_oferta INNER JOIN
                         dbo.vNieodebraneMaterialyWgDostawyZNazwa ON dbo.Dostawy_Zawartosc.ID_Dostawy = dbo.vNieodebraneMaterialyWgDostawyZNazwa.ID_Dostawy AND 
                         dbo.Dostawy_Zawartosc.ID_Element = dbo.vNieodebraneMaterialyWgDostawyZNazwa.ID_Element
GO
-- zawiera informacje do sprawdzenia ktore dostawy nie zostaly wydane /zawiera wszystkie przypisane dostawy/
CREATE VIEW [dbo].[vDostawyMagazynuIDostawcow]
AS
SELECT        Wszystko.ID_Zamowienia, Wszystko.ID_Dostawy, dbo.Elementy.ID_Element, dbo.Elementy.Element_Nazwa, SUM(Wszystko.Ilosc) * - 1 AS Ilosc
FROM            (SELECT        ID_Dostawy, ID_Zamowienia, ID_Element, Ilosc
                          FROM            dbo.vMaterialyZamowione
                          UNION ALL
                          SELECT        ID_Dostawy, ID_Zamowienia, ID_Element, Ilosc
                          FROM            dbo.vMaterialyZMagazynu) AS Wszystko INNER JOIN
                         dbo.Elementy ON Wszystko.ID_Element = dbo.Elementy.ID_Element
GROUP BY Wszystko.ID_Zamowienia, Wszystko.ID_Dostawy, dbo.Elementy.Element_Nazwa, dbo.Elementy.ID_Element
HAVING        (SUM(Wszystko.Ilosc) * - 1 > 0)
GO
-- lista niewydanych dostaw, potrzebuje dodania tabeli w osobnym widoku aby miec daty
CREATE VIEW [dbo].[vDostawyNiewydaneBezDat]
AS
SELECT        dbo.vDostawyDoWydania.ID_Zamowienia, dbo.Zamowienie_Element.ID_Zamowienie_Element, dbo.vDostawyDoWydania.ID_Element, dbo.vDostawyDoWydania.Element_Nazwa, dbo.vDostawyDoWydania.Ilosc, 
                         dbo.vDostawyDoWydania.ID_Dostawy
FROM            dbo.Proces_Technologiczny INNER JOIN
                         dbo.Elementy_Proces ON dbo.Proces_Technologiczny.ID_Proces_Technologiczny = dbo.Elementy_Proces.ID_Proces_Technologiczny INNER JOIN
                         dbo.Proces_Zamowienie ON dbo.Proces_Technologiczny.ID_Proces_Technologiczny = dbo.Proces_Zamowienie.ID_Proces_Technologiczny INNER JOIN
                         dbo.vDostawyDoWydania INNER JOIN
                         dbo.Zamowienia ON dbo.vDostawyDoWydania.ID_Zamowienia = dbo.Zamowienia.ID_Zamowienia INNER JOIN
                         dbo.Zamowienie_Element ON dbo.Zamowienia.ID_Zamowienia = dbo.Zamowienie_Element.ID_Zamowienia ON dbo.Proces_Zamowienie.ID_Zamowienie_Element = dbo.Zamowienie_Element.ID_Zamowienie_Element AND 
                         dbo.Elementy_Proces.ID_Element = dbo.vDostawyDoWydania.ID_Element
GO
-- lista niewydanych dostaw, tym razem z datami, uwzglednia czy te rzeczy sa na polce
CREATE VIEW [dbo].[vMaterialyNiewydaneZDatami]
AS
SELECT DISTINCT 
                         dbo.vDostawyNiewydaneBezDat.ID_Zamowienia, dbo.vDostawyNiewydaneBezDat.ID_Zamowienie_Element, dbo.vDostawyNiewydaneBezDat.ID_Element, dbo.vDostawyNiewydaneBezDat.Element_Nazwa, 
                         dbo.vDostawyNiewydaneBezDat.Ilosc, dbo.vDostawyNiewydaneBezDat.ID_Dostawy, dbo.vPotrzebyProdukcjiZDatami.Proponowana_data_dostawy_materialu, dbo.Zawartosc.ID_Polka
FROM            dbo.vDostawyNiewydaneBezDat INNER JOIN
                         dbo.vPotrzebyProdukcjiZDatami ON dbo.vDostawyNiewydaneBezDat.ID_Zamowienie_Element = dbo.vPotrzebyProdukcjiZDatami.ID_Zamowienie_Element INNER JOIN
                         dbo.Zawartosc ON dbo.vDostawyNiewydaneBezDat.ID_Element = dbo.Zawartosc.ID_Element AND dbo.vDostawyNiewydaneBezDat.ID_Dostawy = dbo.Zawartosc.ID_Dostawy
GO
--lista zam�wie� bez przypisanych pracownik�w i kurier�w
CREATE VIEW [dbo].[vZamowieniaNieprzypisaneDoPracownikaIKuriera]
AS
SELECT        dbo.Zamowienia.ID_Zamowienia
FROM            dbo.Zamowienia_Przydzial RIGHT OUTER JOIN
                         dbo.Zamowienia ON dbo.Zamowienia_Przydzial.ID_Zamowienia = dbo.Zamowienia.ID_Zamowienia INNER JOIN
                         dbo.Klienci ON dbo.Zamowienia.ID_Klienta = dbo.Klienci.ID_Klienta
WHERE        (dbo.Zamowienia_Przydzial.ID_Zamowienia IS NULL)
GO
--dystans na kt�ry trzeba dostarczy� zam�wienie
CREATE VIEW [dbo].[vZamowieniaDystans]
AS
SELECT        dbo.Zamowienia.ID_Zamowienia, dbo.Klienci.Odleglosc_km
FROM            dbo.Zamowienia INNER JOIN
                         dbo.Klienci ON dbo.Zamowienia.ID_Klienta = dbo.Klienci.ID_Klienta
GO
--widok umow z kurierami
CREATE VIEW [dbo].[vUmowyKurierzy]
SELECT        dbo.Umowy_Kurierzy.ID_Umowy, dbo.Kurierzy.Nazwa, dbo.Umowy_Kurierzy.Data_Zawarcia, dbo.Umowy_Kurierzy.Czas_Dostawy, dbo.Umowy_Kurierzy.Koszt_Km, dbo.Umowy_Kurierzy.Koszt_Staly, NULL 
                         AS Koszt_calkowity
FROM            dbo.Umowy_Kurierzy INNER JOIN
                         dbo.Kurierzy ON dbo.Umowy_Kurierzy.ID_Kurier = dbo.Kurierzy.ID_Kurier
GO
--widok nazw kurier�w
CREATE VIEW [dbo].[vUmowyKurierzyNazwyKurierow]
AS
SELECT        dbo.Umowy_Kurierzy.ID_Umowy, dbo.Kurierzy.Nazwa
FROM            dbo.Kurierzy INNER JOIN
                         dbo.Umowy_Kurierzy ON dbo.Kurierzy.ID_Kurier = dbo.Umowy_Kurierzy.ID_Kurier
GO

---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------WIDOKI PRODUKCJA----------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------

--realizacja procesu produkcyjnego

CREATE VIEW vRealizacjaProcesuProdukcyjnegoDetails 
AS
SELECT dbo.Proces_Produkcyjny.ID_Procesu_Produkcyjnego, dbo.Realizacja_Procesu.ID_Realizacji_Procesu, dbo.Rodzaj_Etapu.Nazwa as 'Nazwa etapu', dbo.Realizacja_Procesu.Data_Rozpoczecia_Procesu, 
                  dbo.Realizacja_Procesu.Data_Zakonczenia_Procesu
FROM     dbo.Realizacja_Procesu INNER JOIN
                  dbo.Rodzaj_Etapu ON dbo.Realizacja_Procesu.ID_Etapu = dbo.Rodzaj_Etapu.ID_Etapu INNER JOIN
                  dbo.Proces_Produkcyjny ON dbo.Realizacja_Procesu.ID_Procesu_Produkcyjnego = dbo.Proces_Produkcyjny.ID_Procesu_Produkcyjnego
				  
				  
GO

-- widok Procesu Produkcyjnego dla ID Zamowienia
CREATE VIEW vZamowienieProcesyProdukcyjne 
AS
SELECT        dbo.Proces_Produkcyjny.ID_Procesu_Produkcyjnego, dbo.Zamowienie_Element.ID_Zamowienia, dbo.Proces_Produkcyjny.ID_Zamowienie_Element, dbo.Elementy_Typy.Typ, 
                         dbo.Proces_Produkcyjny.Proponowana_data_dostawy_materialu, dbo.Proces_Produkcyjny.Data_Rozpoczecia, dbo.Proces_Produkcyjny.Data_Zakonczenia, dbo.Proces_Produkcyjny.Uwagi
FROM            dbo.Proces_Produkcyjny INNER JOIN
                         dbo.Zamowienie_Element ON dbo.Proces_Produkcyjny.ID_Zamowienie_Element = dbo.Zamowienie_Element.ID_Zamowienie_Element INNER JOIN
                         dbo.Elementy ON dbo.Zamowienie_Element.ID_Element = dbo.Elementy.ID_Element INNER JOIN
                         dbo.Elementy_Typy ON dbo.Elementy.ID_Element_Typ = dbo.Elementy_Typy.ID_Element_Typ
GO

-- widok Procesu Produkcyjnego dla ID Zamowienie Element

CREATE VIEW vIdZamowienieElementProcesProdukcyjny 
AS
SELECT        dbo.Zamowienie_Element.ID_Zamowienie_Element, dbo.Proces_Produkcyjny.ID_Procesu_Produkcyjnego, dbo.Proces_Produkcyjny.ID_Zamowienie_Element AS Expr1, 
                         dbo.Proces_Produkcyjny.Proponowana_data_dostawy_materialu, dbo.Proces_Produkcyjny.Data_Rozpoczecia, dbo.Proces_Produkcyjny.Data_Zakonczenia, dbo.Proces_Produkcyjny.Uwagi
FROM            dbo.Proces_Produkcyjny INNER JOIN
                         dbo.Zamowienie_Element ON dbo.Proces_Produkcyjny.ID_Zamowienie_Element = dbo.Zamowienie_Element.ID_Zamowienie_Element
GO


---SREDNI CZAS TRWANIA PROCESU

CREATE VIEW vRoznicaDatDni
AS
SELECT ID_Procesu_Produkcyjnego, DATEDIFF(dd, Data_Rozpoczecia, Data_Zakonczenia) as 'Roznica_dat_dni'
FROM     dbo.Proces_Produkcyjny

GO

CREATE VIEW vRoznicaDniBezWeekend
AS
SELECT dbo.Proces_Produkcyjny.ID_Procesu_Produkcyjnego,  
CASE WHEN (datepart(dw,dbo.Proces_Produkcyjny.Data_Rozpoczecia) + dbo.vRoznicaDatDni.Roznica_dat_dni) > 6 THEN (dbo.vRoznicaDatDni.Roznica_dat_dni - 2) 
ELSE dbo.vRoznicaDatDni.Roznica_dat_dni
end as 'Roznica_dni_bez_weekendu'
FROM     dbo.Proces_Produkcyjny INNER JOIN
                  dbo.vRoznicaDatDni ON dbo.Proces_Produkcyjny.ID_Procesu_Produkcyjnego = dbo.vRoznicaDatDni.ID_Procesu_Produkcyjnego

GO

CREATE VIEW vRoznicaGodzin
AS
SELECT  dbo.Proces_Produkcyjny.ID_Procesu_Produkcyjnego, dbo.Proces_Produkcyjny.Data_Rozpoczecia ,dbo.Proces_Produkcyjny.Data_Zakonczenia,
CASE 
WHEN dbo.vRoznicaDniBezWeekend.Roznica_dni_bez_weekendu = 0 THEN DATEDIFF(hh, dbo.Proces_Produkcyjny.Data_Rozpoczecia, dbo.Proces_Produkcyjny.Data_Zakonczenia)
ELSE (22-DATEPART(hh, dbo.Proces_Produkcyjny.Data_Rozpoczecia))+(DATEPART(hh,  dbo.Proces_Produkcyjny.Data_Zakonczenia)-6)+((dbo.vRoznicaDniBezWeekend.Roznica_dni_bez_weekendu-1)*16)
END AS 'Roznica_godzin'
FROM     dbo.Proces_Produkcyjny INNER JOIN
                  dbo.vRoznicaDniBezWeekend ON dbo.Proces_Produkcyjny.ID_Procesu_Produkcyjnego = dbo.vRoznicaDniBezWeekend.ID_Procesu_Produkcyjnego

GO

CREATE VIEW vSredniCzasWgElementu
AS
SELECT  ISNULL(ROW_NUMBER() OVER(ORDER BY (SELECT NULL)), -1) as 'id', dbo.Elementy_Typy.Typ as 'Nazwa_produktu', avg(dbo.vRoznicaGodzin.Roznica_godzin) as'Sredni_czas'
FROM     dbo.Elementy_Typy INNER JOIN
                  dbo.Elementy ON dbo.Elementy_Typy.ID_Element_Typ = dbo.Elementy.ID_Element_Typ INNER JOIN
                  dbo.Zamowienie_Element ON dbo.Elementy.ID_Element = dbo.Zamowienie_Element.ID_Element INNER JOIN
                  dbo.Proces_Produkcyjny INNER JOIN
                  dbo.vRoznicaGodzin ON dbo.Proces_Produkcyjny.ID_Procesu_Produkcyjnego = dbo.vRoznicaGodzin.ID_Procesu_Produkcyjnego ON 
                  dbo.Zamowienie_Element.ID_Zamowienie_Element = dbo.Proces_Produkcyjny.ID_Zamowienie_Element
GROUP BY dbo.Elementy_Typy.Typ

GO
------
------Szacowany czas wykonania zamowienia
------
CREATE VIEW vSzacowanyCzasWykonania
AS
SELECT ISNULL(ROW_NUMBER() OVER(ORDER BY (SELECT NULL)), -1) as 'id', dbo.Elementy_Typy.Typ ,   CURRENT_TIMESTAMP + ((((dbo.vSredniCzasWgElementu.Sredni_czas - (22- datepart(hh,CURRENT_TIMESTAMP)))/16)+1)*8 + vSredniCzasWgElementu.Sredni_czas)/24.00 + (((((dbo.vSredniCzasWgElementu.Sredni_czas - (22- datepart(hh,CURRENT_TIMESTAMP)))/16)+1) + DATEPART(dw,CURRENT_TIMESTAMP))/7)*2 as 'Szacowany_czas_wykonania'
FROM     dbo.Elementy_Typy INNER JOIN
                  dbo.Elementy ON dbo.Elementy_Typy.ID_Element_Typ = dbo.Elementy.ID_Element_Typ INNER JOIN
                  dbo.Zamowienie_Element ON dbo.Elementy.ID_Element = dbo.Zamowienie_Element.ID_Element INNER JOIN
                  dbo.Proces_Produkcyjny ON dbo.Zamowienie_Element.ID_Zamowienie_Element = dbo.Proces_Produkcyjny.ID_Zamowienie_Element INNER JOIN
                  dbo.vSredniCzasWgElementu ON dbo.Elementy_Typy.Typ = dbo.vSredniCzasWgElementu.Nazwa_produktu

GO

-----Proces generuj�cy najwi�cej odpadow w miesiacu
 
CREATE VIEW vProcesMaxOdpadMiesiac
AS
SELECT ISNULL(ROW_NUMBER() OVER(ORDER BY (SELECT NULL)), -1) as 'id', datepart(mm, dbo.Proces_Produkcyjny.Data_Zakonczenia) as 'Miesiac', max(dbo.Material_Na_Produkcji.Odpad) as 'Max_odpad_w_msc'
FROM     dbo.Proces_Produkcyjny INNER JOIN
                  dbo.Material_Na_Produkcji ON dbo.Proces_Produkcyjny.ID_Procesu_Produkcyjnego = dbo.Material_Na_Produkcji.ID_Procesu_Produkcyjnego
GROUP BY datepart(mm, dbo.Proces_Produkcyjny.Data_Zakonczenia)

GO

---Niezuzyte w miesiacu

CREATE VIEW vNiezuzyteWMiesiacu
AS
SELECT ISNULL(ROW_NUMBER() OVER(ORDER BY (SELECT NULL)), -1) as 'id', dbo.Elementy.Element_Nazwa, dbo.Material_Na_Produkcji.Niezuzyty_material,  dbo.Elementy_Jednostki.Jednostka, datepart(mm, dbo.Proces_Produkcyjny.Data_Zakonczenia) as 'Miesiac'
FROM     dbo.Proces_Produkcyjny INNER JOIN
                  dbo.Material_Na_Produkcji ON dbo.Proces_Produkcyjny.ID_Procesu_Produkcyjnego = dbo.Material_Na_Produkcji.ID_Procesu_Produkcyjnego INNER JOIN
                  dbo.Elementy_Proces ON dbo.Material_Na_Produkcji.ID_Elementy_Proces = dbo.Elementy_Proces.ID_Elementy_Proces INNER JOIN
                  dbo.Elementy ON dbo.Elementy_Proces.ID_Element = dbo.Elementy.ID_Element INNER JOIN
                  dbo.Elementy_Cechy ON dbo.Elementy.ID_Element = dbo.Elementy_Cechy.ID_Element INNER JOIN
                  dbo.Elementy_Jednostki ON dbo.Elementy_Cechy.ID_Jednostka = dbo.Elementy_Jednostki.ID_jednostka
GO



---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------WIDOKI PRZYGOTOWANIE PRODUKCJI----------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------

CREATE VIEW vMaszyny_rodzaj_liczba AS
SELECT TOP (100) PERCENT dbo.Maszyny_Proces.ID_Proces_Technologiczny, dbo.Rodzaj_Maszyny.Rodzaj_Maszyny, dbo.Srodki_Trwale.Producent, dbo.Maszyny_Proces.Liczba_Maszyn
FROM     dbo.Rodzaj_Maszyny INNER JOIN
                  dbo.Maszyny_Proces ON dbo.Rodzaj_Maszyny.ID_Rodzaj_Maszyny = dbo.Maszyny_Proces.ID_Rodzaj_Maszyny INNER JOIN
                  dbo.Maszyny ON dbo.Rodzaj_Maszyny.ID_Rodzaj_Maszyny = dbo.Maszyny.ID_Rodzaj_Maszyny INNER JOIN
                  dbo.Srodki_Trwale ON dbo.Maszyny.ID_Srodki_Trwale = dbo.Srodki_Trwale.ID_Srodki_trwale INNER JOIN
                  dbo.Proces_Technologiczny ON dbo.Maszyny_Proces.ID_Proces_Technologiczny = dbo.Proces_Technologiczny.ID_Proces_Technologiczny INNER JOIN
                  dbo.Proces_Zamowienie ON dbo.Proces_Technologiczny.ID_Proces_Technologiczny = dbo.Proces_Zamowienie.ID_Proces_Technologiczny INNER JOIN
                  dbo.Etapy_W_Procesie ON dbo.Proces_Technologiczny.ID_Proces_Technologiczny = dbo.Etapy_W_Procesie.ID_Proces_Technologiczny INNER JOIN
                  dbo.Rodzaj_Etapu ON dbo.Etapy_W_Procesie.ID_Etapu = dbo.Rodzaj_Etapu.ID_Etapu
GROUP BY dbo.Maszyny_Proces.ID_Proces_Technologiczny, dbo.Rodzaj_Maszyny.Rodzaj_Maszyny, dbo.Srodki_Trwale.Producent, dbo.Maszyny_Proces.Liczba_Maszyn
				  GO

CREATE VIEW vMaszyny_serwis  AS
SELECT dbo.Maszyny.ID_Maszyny, dbo.Maszyny.Resurs_Rbh, dbo.Maszyny.Serwis_Co_Ile, dbo.Srodki_Trwale.Producent, dbo.Srodki_Trwale.Nazwa, dbo.Srodki_Trwale.Numer_seryjny
FROM     dbo.Maszyny INNER JOIN
                  dbo.Srodki_Trwale ON dbo.Maszyny.ID_Srodki_Trwale = dbo.Srodki_Trwale.ID_Srodki_trwale
				  GO

CREATE VIEW vObsluga  AS
SELECT        dbo.Srodki_Trwale.Nazwa AS [Nazwa maszyny], dbo.Obsluga_Techniczna.Data_Rozpoczecia AS [Data rozpocz�cia], dbo.Obsluga_Techniczna.Data_Zakonczenia AS [Data zako�czenia], 
                         dbo.Srodki_Trwale.Numer_seryjny AS [Numer seryjny], dbo.Rodzaj_Obslugi.Nazwa AS [Rodzaj obs�ugi], dbo.Pracownicy.Imie + ' ' + dbo.Pracownicy.Nazwisko AS [Imi� i nazwisko]
FROM            dbo.Srodki_Trwale INNER JOIN
                         dbo.Maszyny ON dbo.Srodki_Trwale.ID_Srodki_trwale = dbo.Maszyny.ID_Srodki_Trwale INNER JOIN
                         dbo.Obsluga_Techniczna ON dbo.Maszyny.ID_Maszyny = dbo.Obsluga_Techniczna.ID_Maszyny INNER JOIN
                         dbo.Rodzaj_Maszyny ON dbo.Maszyny.ID_Rodzaj_Maszyny = dbo.Rodzaj_Maszyny.ID_Rodzaj_Maszyny INNER JOIN
                         dbo.Rodzaj_Obslugi ON dbo.Obsluga_Techniczna.ID_Rodzaj_Obslugi = dbo.Rodzaj_Obslugi.ID_Rodzaj_Obslugi INNER JOIN
                         dbo.Pracownicy ON dbo.Obsluga_Techniczna.ID_Pracownika = dbo.Pracownicy.ID_Pracownika
GO

CREATE VIEW vSrednia_ilosc_maszyn AS
SELECT dbo.Rodzaj_Maszyny.Rodzaj_Maszyny, SUM(dbo.Maszyny_Proces.Liczba_Maszyn) / COUNT(dbo.Proces_Zamowienie.ID_Proces_Zamowienie) AS srednia_ilosc_maszyn
FROM     dbo.Proces_Zamowienie INNER JOIN
                  dbo.Maszyny_Proces ON dbo.Maszyny_Proces.ID_Proces_Technologiczny = dbo.Proces_Zamowienie.ID_Proces_Technologiczny INNER JOIN
                  dbo.Rodzaj_Maszyny ON dbo.Maszyny_Proces.ID_Rodzaj_Maszyny = dbo.Rodzaj_Maszyny.ID_Rodzaj_Maszyny
GROUP BY dbo.Rodzaj_Maszyny.Rodzaj_Maszyny
GO

CREATE VIEW vSuma_czasu_procesu AS
SELECT ID_Proces_Technologiczny, SUM(Czas) AS suma_czasu
FROM     dbo.Etapy_W_Procesie
GROUP BY ID_Proces_Technologiczny
GO

CREATE VIEW vProces_technologiczny AS
SELECT        dbo.Zamowienia.ID_Zamowienia AS [Numer zam�wienia], dbo.Elementy.Element_Nazwa AS [Nazwa elementu], dbo.Zamowienie_Element.Ilosc AS [Liczba sztuk],
                         dbo.Proces_Technologiczny.ID_Proces_Technologiczny AS [Numer procesu], dbo.Proces_Zamowienie.Kompletny_Proces AS [Kompletny proces]
FROM            dbo.Zamowienia INNER JOIN
                         dbo.Zamowienie_Element ON dbo.Zamowienia.ID_Zamowienia = dbo.Zamowienie_Element.ID_Zamowienia INNER JOIN
                         dbo.Elementy ON dbo.Zamowienie_Element.ID_Element = dbo.Elementy.ID_Element INNER JOIN
                         dbo.Proces_Zamowienie ON dbo.Zamowienie_Element.ID_Zamowienie_Element = dbo.Proces_Zamowienie.ID_Zamowienie_Element INNER JOIN
                         dbo.Proces_Technologiczny ON dbo.Proces_Zamowienie.ID_Proces_Technologiczny = dbo.Proces_Technologiczny.ID_Proces_Technologiczny
GO

CREATE VIEW vProcesy AS
SELECT        dbo.Proces_Technologiczny.ID_Proces_Technologiczny, dbo.Rodzaj_Etapu.Nazwa, dbo.Etapy_W_Procesie.Czas AS [Czas (h)]
FROM            dbo.Proces_Technologiczny INNER JOIN
                         dbo.Etapy_W_Procesie ON dbo.Proces_Technologiczny.ID_Proces_Technologiczny = dbo.Etapy_W_Procesie.ID_Proces_Technologiczny INNER JOIN
                         dbo.Rodzaj_Etapu ON dbo.Etapy_W_Procesie.ID_Etapu = dbo.Rodzaj_Etapu.ID_Etapu
GROUP BY dbo.Proces_Technologiczny.ID_Proces_Technologiczny, dbo.Rodzaj_Etapu.Nazwa, dbo.Etapy_W_Procesie.Czas
GO

CREATE VIEW vElementy_proces AS
SELECT        dbo.Proces_Technologiczny.ID_Proces_Technologiczny AS [Numer procesu], dbo.Elementy.Element_Nazwa AS [Nazwa elementu], dbo.Elementy_Proces.Liczba, dbo.Elementy_Jednostki.Jednostka
FROM            dbo.Proces_Technologiczny INNER JOIN
                         dbo.Elementy_Proces ON dbo.Proces_Technologiczny.ID_Proces_Technologiczny = dbo.Elementy_Proces.ID_Proces_Technologiczny INNER JOIN
                         dbo.Elementy ON dbo.Elementy_Proces.ID_Element = dbo.Elementy.ID_Element INNER JOIN
                         dbo.Elementy_Jednostki ON dbo.Elementy_Proces.ID_jednostka = dbo.Elementy_Jednostki.ID_jednostka
GO

CREATE VIEW vDokumentacja_proces AS
SELECT        dbo.Proces_Technologiczny.ID_Proces_Technologiczny AS [Numer procesu], dbo.Rodzaj_Dokumentacji.Nazwa AS [Rodzaj dokumentacji], dbo.Pracownicy.Imie + ' ' + dbo.Pracownicy.Nazwisko AS Autor, 
                         dbo.Dokumentacje.Plik AS Lokalizacja, dbo.Dokumentacje.Data_Wykonania AS [Data wykonania]
FROM            dbo.Proces_Technologiczny INNER JOIN
                         dbo.Dokumentacja_Proces ON dbo.Proces_Technologiczny.ID_Proces_Technologiczny = dbo.Dokumentacja_Proces.ID_Proces_Technologiczny INNER JOIN
                         dbo.Dokumentacje ON dbo.Dokumentacja_Proces.ID_Dokumentacji = dbo.Dokumentacje.ID_Dokumentacji INNER JOIN
                         dbo.Rodzaj_Dokumentacji ON dbo.Dokumentacje.ID_Rodzaj_Dokumentacji = dbo.Rodzaj_Dokumentacji.ID_Rodzaj_Dokumentacji INNER JOIN
                         dbo.Pracownicy ON dbo.Dokumentacje.ID_Pracownika = dbo.Pracownicy.ID_Pracownika
GO

CREATE VIEW vEtapy_proces AS
SELECT        dbo.Proces_Technologiczny.ID_Proces_Technologiczny AS [Numer procesu], dbo.Rodzaj_Etapu.Nazwa, dbo.Etapy_W_Procesie.Czas AS [Czas (h)]
FROM            dbo.Proces_Technologiczny INNER JOIN
                         dbo.Etapy_W_Procesie ON dbo.Proces_Technologiczny.ID_Proces_Technologiczny = dbo.Etapy_W_Procesie.ID_Proces_Technologiczny INNER JOIN
                         dbo.Rodzaj_Etapu ON dbo.Etapy_W_Procesie.ID_Etapu = dbo.Rodzaj_Etapu.ID_Etapu
GROUP BY dbo.Proces_Technologiczny.ID_Proces_Technologiczny, dbo.Rodzaj_Etapu.Nazwa, dbo.Etapy_W_Procesie.Czas
GO

CREATE VIEW vTechnolodzy AS
SELECT        dbo.Pracownicy.ID_Pracownika, dbo.Pracownicy.Imie + ' ' + dbo.Pracownicy.Nazwisko AS Autor
FROM            dbo.Pracownicy INNER JOIN
                         dbo.Pracownicy_Zatrudnienie ON dbo.Pracownicy.ID_Pracownika = dbo.Pracownicy_Zatrudnienie.ID_Pracownika INNER JOIN
                         dbo.Stanowisko ON dbo.Pracownicy_Zatrudnienie.ID_Stanowiska = dbo.Stanowisko.ID_Stanowiska
GROUP BY dbo.Pracownicy.Imie, dbo.Pracownicy.Nazwisko, dbo.Stanowisko.Stanowisko, dbo.Pracownicy.ID_Pracownika
HAVING        (dbo.Stanowisko.Stanowisko = 'Technolog')
GO

CREATE VIEW vMaszyny_proces AS
SELECT        dbo.Proces_Technologiczny.ID_Proces_Technologiczny AS [Numer procesu], dbo.Rodzaj_Maszyny.Rodzaj_Maszyny AS [Rodzaj maszyny], dbo.Maszyny_Proces.Liczba_Maszyn AS [Liczba maszyn], 
                         dbo.Maszyny_Proces.Liczba_Rbh_Maszyna AS [Liczba roboczogodzin maszyny], dbo.Rodzaj_Maszyny.Koszt_Rbh AS [Koszt roboczogodziny maszyny]
FROM            dbo.Srodki_Trwale INNER JOIN
                         dbo.Maszyny ON dbo.Srodki_Trwale.ID_Srodki_trwale = dbo.Maszyny.ID_Srodki_Trwale INNER JOIN
                         dbo.Rodzaj_Maszyny ON dbo.Maszyny.ID_Rodzaj_Maszyny = dbo.Rodzaj_Maszyny.ID_Rodzaj_Maszyny INNER JOIN
                         dbo.Proces_Technologiczny INNER JOIN
                         dbo.Maszyny_Proces ON dbo.Proces_Technologiczny.ID_Proces_Technologiczny = dbo.Maszyny_Proces.ID_Proces_Technologiczny ON 
                         dbo.Rodzaj_Maszyny.ID_Rodzaj_Maszyny = dbo.Maszyny_Proces.ID_Rodzaj_Maszyny
GROUP BY dbo.Proces_Technologiczny.ID_Proces_Technologiczny, dbo.Maszyny_Proces.Liczba_Maszyn, dbo.Maszyny_Proces.Liczba_Rbh_Maszyna, dbo.Rodzaj_Maszyny.Rodzaj_Maszyny, dbo.Rodzaj_Maszyny.Koszt_Rbh
GO

CREATE VIEW vDokumentacja_technologiczna AS
SELECT        dbo.Rodzaj_Dokumentacji.Nazwa
FROM            dbo.Proces_Technologiczny INNER JOIN
                         dbo.Dokumentacja_Proces ON dbo.Proces_Technologiczny.ID_Proces_Technologiczny = dbo.Dokumentacja_Proces.ID_Proces_Technologiczny INNER JOIN
                         dbo.Dokumentacje ON dbo.Dokumentacja_Proces.ID_Dokumentacji = dbo.Dokumentacje.ID_Dokumentacji INNER JOIN
                         dbo.Pracownicy ON dbo.Dokumentacje.ID_Pracownika = dbo.Pracownicy.ID_Pracownika INNER JOIN
                         dbo.Rodzaj_Dokumentacji ON dbo.Dokumentacje.ID_Rodzaj_Dokumentacji = dbo.Rodzaj_Dokumentacji.ID_Rodzaj_Dokumentacji
GROUP BY dbo.Rodzaj_Dokumentacji.Nazwa
GO

CREATE VIEW vResurs AS
SELECT        TOP (100) PERCENT dbo.Przydzial_Zasobow.ID_Maszyny, dbo.Srodki_Trwale.Producent, dbo.Srodki_Trwale.Nazwa, dbo.Srodki_Trwale.Numer_seryjny, dbo.Maszyny.Resurs_Rbh - DATEDIFF(HH,
                         dbo.Przydzial_Zasobow.Data_Rozpoczecia, dbo.Przydzial_Zasobow.Data_Zakonczenia) AS Pozostaly_Resurs
FROM            dbo.Przydzial_Zasobow INNER JOIN
                         dbo.Maszyny ON dbo.Przydzial_Zasobow.ID_Maszyny = dbo.Maszyny.ID_Maszyny INNER JOIN
                         dbo.Rodzaj_Maszyny ON dbo.Maszyny.ID_Rodzaj_Maszyny = dbo.Rodzaj_Maszyny.ID_Rodzaj_Maszyny INNER JOIN
                         dbo.Srodki_Trwale ON dbo.Maszyny.ID_Srodki_Trwale = dbo.Srodki_Trwale.ID_Srodki_trwale
ORDER BY dbo.Przydzial_Zasobow.ID_Maszyny
GO

CREATE VIEW vCzas_do_serwisu AS
SELECT dbo.Srodki_Trwale.Producent, dbo.Srodki_Trwale.Nazwa, dbo.Srodki_Trwale.Numer_seryjny, CONVERT (date ,DATEADD(DD, dbo.Maszyny.Serwis_Co_Ile, dbo.Obsluga_Techniczna.Data_Zakonczenia),120) AS Kiedy_Serwis
FROM     dbo.Maszyny INNER JOIN
                  dbo.Rodzaj_Maszyny ON dbo.Maszyny.ID_Rodzaj_Maszyny = dbo.Rodzaj_Maszyny.ID_Rodzaj_Maszyny INNER JOIN
                  dbo.Srodki_Trwale ON dbo.Maszyny.ID_Srodki_Trwale = dbo.Srodki_Trwale.ID_Srodki_trwale INNER JOIN
                  dbo.Obsluga_Techniczna ON dbo.Maszyny.ID_Maszyny = dbo.Obsluga_Techniczna.ID_Maszyny INNER JOIN
                  dbo.Rodzaj_Obslugi ON dbo.Obsluga_Techniczna.ID_Rodzaj_Obslugi = dbo.Rodzaj_Obslugi.ID_Rodzaj_Obslugi
WHERE  (dbo.Rodzaj_Obslugi.Nazwa = 'Serwis')
GO

CREATE VIEW vProces_Etapy AS
SELECT        dbo.Proces_Technologiczny.ID_Proces_Technologiczny, dbo.Rodzaj_Etapu.Nazwa, dbo.Etapy_W_Procesie.Czas
FROM            dbo.Proces_Technologiczny INNER JOIN
                         dbo.Etapy_W_Procesie ON dbo.Proces_Technologiczny.ID_Proces_Technologiczny = dbo.Etapy_W_Procesie.ID_Proces_Technologiczny INNER JOIN
                         dbo.Rodzaj_Etapu ON dbo.Etapy_W_Procesie.ID_Etapu = dbo.Rodzaj_Etapu.ID_Etapu
GROUP BY dbo.Proces_Technologiczny.ID_Proces_Technologiczny, dbo.Rodzaj_Etapu.Nazwa, dbo.Etapy_W_Procesie.Czas
GO

CREATE VIEW vProces_Maszyna AS
SELECT        dbo.Proces_Technologiczny.ID_Proces_Technologiczny, dbo.Rodzaj_Maszyny.Rodzaj_Maszyny, dbo.Maszyny_Proces.Liczba_Maszyn, dbo.Maszyny_Proces.Liczba_Rbh_Maszyna
FROM            dbo.Proces_Technologiczny INNER JOIN
                         dbo.Maszyny_Proces ON dbo.Proces_Technologiczny.ID_Proces_Technologiczny = dbo.Maszyny_Proces.ID_Proces_Technologiczny INNER JOIN
                         dbo.Rodzaj_Maszyny ON dbo.Maszyny_Proces.ID_Rodzaj_Maszyny = dbo.Rodzaj_Maszyny.ID_Rodzaj_Maszyny
GO



CREATE VIEW vWszystkie_Elementy AS
SELECT        ID_Element, Element_Nazwa
FROM            dbo.Elementy
GO

CREATE VIEW vWszystkie_Maszyny AS
SELECT        dbo.Maszyny.ID_Maszyny, dbo.Srodki_Trwale.Producent, dbo.Srodki_Trwale.Nazwa, dbo.Srodki_Trwale.Numer_seryjny, dbo.Rodzaj_Maszyny.Rodzaj_Maszyny
FROM            dbo.Srodki_Trwale INNER JOIN
                         dbo.Maszyny ON dbo.Srodki_Trwale.ID_Srodki_trwale = dbo.Maszyny.ID_Srodki_Trwale INNER JOIN
                         dbo.Rodzaj_Maszyny ON dbo.Maszyny.ID_Rodzaj_Maszyny = dbo.Rodzaj_Maszyny.ID_Rodzaj_Maszyny
GO

CREATE VIEW vRodzaj_Maszyny AS
SELECT        ID_Rodzaj_Maszyny, Rodzaj_Maszyny
FROM            dbo.Rodzaj_Maszyny
GO

CREATE VIEW vMaszyny_numer_seryjny AS
SELECT        dbo.Maszyny.ID_Maszyny, dbo.Srodki_Trwale.Nazwa + ', ' + dbo.Srodki_Trwale.Numer_seryjny AS Suma
FROM            dbo.Srodki_Trwale INNER JOIN
                         dbo.Maszyny ON dbo.Srodki_Trwale.ID_Srodki_trwale = dbo.Maszyny.ID_Srodki_Trwale
GROUP BY dbo.Maszyny.ID_Maszyny, dbo.Srodki_Trwale.Nazwa, dbo.Srodki_Trwale.Numer_seryjny
GO

CREATE VIEW vDokumentacja_info AS
SELECT        dbo.Proces_Technologiczny.ID_Proces_Technologiczny AS [Numer procesu], dbo.Rodzaj_Dokumentacji.Nazwa AS Rodzaj, dbo.Pracownicy.Imie + ' ' + dbo.Pracownicy.Nazwisko AS [Imi� i nazwisko], 
                         dbo.Dokumentacje.Data_Wykonania AS [Data wykonania]
FROM            dbo.Proces_Technologiczny INNER JOIN
                         dbo.Dokumentacja_Proces ON dbo.Proces_Technologiczny.ID_Proces_Technologiczny = dbo.Dokumentacja_Proces.ID_Proces_Technologiczny INNER JOIN
                         dbo.Dokumentacje ON dbo.Dokumentacja_Proces.ID_Dokumentacji = dbo.Dokumentacje.ID_Dokumentacji INNER JOIN
                         dbo.Pracownicy ON dbo.Dokumentacje.ID_Pracownika = dbo.Pracownicy.ID_Pracownika INNER JOIN
                         dbo.Rodzaj_Dokumentacji ON dbo.Dokumentacje.ID_Rodzaj_Dokumentacji = dbo.Rodzaj_Dokumentacji.ID_Rodzaj_Dokumentacji
GROUP BY dbo.Proces_Technologiczny.ID_Proces_Technologiczny, dbo.Rodzaj_Dokumentacji.Nazwa, dbo.Dokumentacje.Data_Wykonania, dbo.Pracownicy.Imie, dbo.Pracownicy.Nazwisko
GO

CREATE VIEW vProces_elementy AS
SELECT        dbo.Proces_Technologiczny.ID_Proces_Technologiczny AS [Numer procesu], dbo.Rodzaj_Etapu.Nazwa AS [Nazwa etapu], dbo.Etapy_W_Procesie.Czas AS [Czas godziny]
FROM            dbo.Proces_Technologiczny INNER JOIN
                         dbo.Etapy_W_Procesie ON dbo.Proces_Technologiczny.ID_Proces_Technologiczny = dbo.Etapy_W_Procesie.ID_Proces_Technologiczny INNER JOIN
                         dbo.Rodzaj_Etapu ON dbo.Etapy_W_Procesie.ID_Etapu = dbo.Rodzaj_Etapu.ID_Etapu
GROUP BY dbo.Proces_Technologiczny.ID_Proces_Technologiczny, dbo.Rodzaj_Etapu.Nazwa, dbo.Etapy_W_Procesie.Czas
GO

---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------KONIEC PRZYGOTOWANIE PRODUKCJI----------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
USE master