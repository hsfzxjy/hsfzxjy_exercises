{*************************************************************************}
{*                                                                       *}
{*                  III Olimpiada Informatyczna                          *}
{*                                                                       *}
{*   Rozwiazanie zadania: AGENCI                                         *}
{*   Plik:                AGE.PAS                                        *}
{*   Autor:               Albert Krzymowski                              *}
{*************************************************************************}

{$B-}
{$M 64000,0,600000}
program _Agenci;
{************************************************************************}
{                           S T A L E                                    }
{************************************************************************}
 const
  CPLIKWE      ='AGE.IN';
  CPLIKWY      ='AGE.OUT';
  CMAXAGENTOW  =3005;
  CMAXPAPIEROW =8000;
  CMAXWALUTA   =32000;
  CNIEPRZEKUPNY=CMAXWALUTA + 1;
  CPUSTE       =0;
{************************************************************************}
{                           T Y P Y                                      }
{************************************************************************}
 type
  TNrAgenta=0..CMAXAGENTOW;
  TWaluta  =1..CNIEPRZEKUPNY;
  TPapiery =0..CMAXPAPIEROW;
  PSasiad  =^TSasiad;     {lista sasiedztwa}
  TSasiad  =record
             Agent:TNrAgenta;
             Nast :PSasiad
            end;
  TAgent   =record         {Agent:}
             MamPapiery  :PSasiad;   {kogo moge zaaresztowac              }
             MajaPapiery :PSasiad;   {kto mnie moze zaaresztowac          }
             Lapowka     :TWaluta;   {za jaka kwote odsprzedam dokumenty  }
             Numer       :TNrAgenta; {numer agenta wg. DFS                }
             NrSkladowej :TNrAgenta; {nr silnie spojnej sklad. zaw. agenta}
             RozPoddrzewa:TNrAgenta  {rozmiar poddrzewa DFS               }
            end;
  TSkladowa=record
             Minimalna    :boolean; {nie jest osiagalna z innej skladow.}
             MinLapowka   :TWaluta  {minimalna lapowka w tej skladowej  }
            end;
{************************************************************************}
{                         Z M I E N N E                                  }
{************************************************************************}
 var
  Agenci       :array[TNrAgenta] of TAgent;     { Dane o agentach     }
  Numeracja    :array[TNrAgenta] of TNrAgenta;  { Numeracja FDS       }
                {Numeracja[i]=Numer poz. w tab. Agenci opisujacej     }
                {i-tego agenta                                        }
  Skladowe     :array[TNrAgenta] of TSkladowa;  { s. spoj. skladowe   }
  IluAgentow   :TNrAgenta;               { liczba agentow             }
  IleSkladowych:TNrAgenta;               { liczba s. spoj. skladowych }
{************************************************************************}
{               P R O C E D U R Y    I    F U N K C J E                  }
{************************************************************************}
 procedure WczytajDane;
  var
   p             :text;
   nr,nr1,nr2    :TNrAgenta;
   IluPrzekupnych:TNrAgenta;
   IlePapierow,i :TPapiery;
   Suma          :TWaluta;
{************************************************************************}
{  >>>>> procedure initVars - inicjalizuje zmienne globalne              }
{************************************************************************}
  procedure InitVars;
   var i:TNrAgenta;
  begin
   for i:=1 to CMAXAGENTOW do begin
    with Skladowe[i] do begin
     Minimalna:=true;
     MinLapowka:=CNIEPRZEKUPNY
    end;
    with Agenci[i] do begin
     MamPapiery:=nil;  MajaPapiery:=nil;
     Lapowka:=CNIEPRZEKUPNY;
     Numer:=CPUSTE;  NrSkladowej:=CPUSTE;
     RozPoddrzewa:=0
    end {with}
   end {for i:=1 }
  end; {InitVars}
{************************************************************************}
{  >>>>> procedure DodajPapiery - dodaje krawedzie w grafie              }
{************************************************************************}
  procedure DodajPapiery(Agent1,Agent2:TNrAgenta);
   var Pom:PSasiad;
  begin
   new(Pom);
   Pom^.Agent:=Agent2;
   Pom^.Nast:=Agenci[Agent1].MamPapiery;
   Agenci[Agent1].MamPapiery:=Pom;
   new(Pom);
   Pom^.Agent:=Agent1;
   Pom^.Nast:=Agenci[Agent2].MajaPapiery;
   Agenci[Agent2].MajaPapiery:=pom
  end; {DodajPapiery}
{*************************** >>>> WczytajDane <<<<< ************************}
 begin
  InitVars;
  assign(p,CPLIKWE);
  reset(p);
  readln(p,IluAgentow);
  readln(p,IluPrzekupnych);
  for i:=1 to IluPrzekupnych do begin
   readln(p,nr,Suma);
   Agenci[nr].Lapowka:=Suma
  end;
  readln(p,IlePapierow);
  for i:=1 to IlePapierow do begin
   readln(p,nr1,nr2);
   DodajPapiery(nr1,nr2)
  end;
  close(p)
 end; {WczytajDane}
{*************************************************************************}
{  >>>>> procedure Numeruj - przechodzi graf DFS, kolejnosc odwiedzanych  }
{ wierzcholkow jest zapamietywana w tablicy Numeracja, ponadto numer      }
{ wierzcholka zostanie wpisany do pola 'Numer' w tablicy Agenci           }
{*************************************************************************}
 procedure Numeruj;
  var AktNumer,i:TNrAgenta;
{************************************************************************}
{  >>>>> function NumDFS                                                 }
{************************************************************************}
  procedure NumDFS(Akt:TNrAgenta);
   var Suwak:PSasiad;
  begin
   with Agenci[Akt] do begin
    Numer:=AktNumer;
    Numeracja[Numer]:=Akt;
    inc(AktNumer);
    RozPoddrzewa:=1;
    Suwak:=MamPapiery;
    while Suwak<>nil do begin
     if Agenci[Suwak^.Agent].Numer=CPUSTE then begin
      NumDFS(Suwak^.Agent);
      RozPoddrzewa:=RozPoddrzewa+Agenci[Suwak^.Agent].RozPoddrzewa
     end;
     Suwak:=Suwak^.Nast
    end {while Suwak<>nil}
   end {with Agenci[Akt]}
  end; {NumDFS}
{*************************** >>>> Numeracja <<<<< ************************}
 begin
  AktNumer:=1;
  for i:=1 to IluAgentow do
   if Agenci[i].Numer=CPUSTE then NumDFS(i)
 end; {Numeruj}
{*************************************************************************}
{  >>>>> procedure SpojneSkladowe - znajduje silnie spojne skladowe grafu,}
{ przechodzi graf DFS ale "wstecz" po krawedziach MajaPapiery; rozpoczyna }
{ przeszukiwanie w kolejnosci takiej, jak szedl poprzedni DSF, mozna       }
{ odwiedzic tylko tych sasiadow, ktorzy sa w typ samym poddrzewie DFS1    }
{ stad warunek:
{  nr korzenia < nr odwiedzanego sasiada < nr korzenia + rozmiar poddrzewa}
{*************************************************************************}
 procedure SpojneSkladowe;
  var i:TNrAgenta;
{************************************************************************}
{  >>>>> procedure skladowaDFS                                           }
{************************************************************************}
  procedure SkladowaDFS(Akt:TNrAgenta);
   var Suwak:PSasiad;
  begin
   with Agenci[Akt] do begin
    NrSkladowej:=IleSkladowych; {nr budowanej skladowej}
    Suwak:=MajaPapiery;
    while Suwak<>nil do
     with Agenci[Suwak^.Agent] do begin { Numeracja[i] - korzen drzewa }
      if (NrSkladowej=CPUSTE) and (Numer>i) and
         (Numer<i+Agenci[Numeracja[i]].RozPoddrzewa)
      then SkladowaDFS(Suwak^.Agent);
      Suwak:=Suwak^.Nast
     end {with }
   end {with Agenci[Akt] }
  end; {SkaldowaDFS}
{************************ >>>> SpojneSkladowe <<<<< ***********************}
 begin
  IleSkladowych:=0;
  for i:=1 to IluAgentow do
   if Agenci[Numeracja[i]].NrSkladowej=CPUSTE then begin
    inc(IleSkladowych);
    SkladowaDFS(Numeracja[i])
   end
 end; {SpojneSkladowe}
{************************************************************************}
{  >>>>> procedure MinSkladowe - znajdz minimalne skladowe, tzn. takie do}
{ ktorych nie da sie dojsc z innych skladowych po lukach      MamPapiery }
{************************************************************************}
 procedure MinSkladowe;
  var i:TNrAgenta; Suwak:PSasiad;
 begin
  for i:=1 to IluAgentow do
   with Agenci[i] do begin
    Suwak:=MamPapiery;
    while Suwak<>nil do begin
     if NrSkladowej<>Agenci[Suwak^.Agent].NrSkladowej then
      Skladowe[Agenci[Suwak^.Agent].NrSkladowej].Minimalna:=false;
     Suwak:=Suwak^.Nast
    end {while}
  end {with, for}
 end; {MinSkladowe}
{************************************************************************}
{  >>>>> procedure ObliczLapowki - min lapowka dla kazdej min skladowej  }
{************************************************************************}
 procedure ObliczLapowki;
  var i:TNrAgenta;
 begin
  for i:=1 to IluAgentow do
   with Agenci[i] do
    if Skladowe[NrSkladowej].Minimalna and
       (Lapowka<Skladowe[NrSkladowej].MinLapowka) then
     Skladowe[NrSkladowej].MinLapowka:=Lapowka
 end; {ObliczLapowki}
{************************************************************************}
{  >>>>> procedure Odpowiedz - wypisuje rozwiazanie                      }
{************************************************************************}
 procedure Odpowiedz;
  var
   JestRozwiazanie:boolean;
   i,j            :TNrAgenta;
   Suma           :longint;
   p              :text;
   KontrPrzyklad  :TNrAgenta;
 begin
  JestRozwiazanie:=true;
  Suma:=0;
  i:=1;
  while (i<=IleSkladowych) and JestRozwiazanie do begin
   with Skladowe[i] do
    if Minimalna then
     if MinLapowka=CNIEPRZEKUPNY then JestRozwiazanie:=false
     else Suma:=Suma+MinLapowka;
   i:=i+1
  end; {while}
   { Znajdz agenta, ktorego nie mozna aresztowac.                         }
  if not JestRozwiazanie then begin
   i:=i-1;
   KontrPrzyklad:=1;
   while Agenci[KontrPrzyklad].NrSkladowej<>i do
    KontrPrzyklad:=KontrPrzyklad+1
  end; {if }
  assign(p,CPLIKWY);
  rewrite(p);
  if JestRozwiazanie then begin
   writeln(p,'YES');
   writeln(p,Suma)
  end {JestRozwiazanie}
  else begin
   writeln(p,'NO');
   writeln(p,KontrPrzyklad)
  end;
  close(p)
 end; {Odpowiedz}
{************************************************************************}
{                               M A I N                                  }
{************************************************************************}
begin
 WczytajDane;
 Numeruj;
 SpojneSkladowe;
 MinSkladowe;
 ObliczLapowki;
 Odpowiedz;
end.