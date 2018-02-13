# Mehrschichtsystem Mikrolochplatte - Luftkaverne

## Grunds&auml;tzliches

Mit der vorliegenden App k&ouml;nnen drei mikroperforierte Platten und drei Luftkavernen als Schichtensystem in ihrer akustischen Absorptionseigenschaft berechnet und simuliert werden. Dazu wird angenommen, dass das Schichtensystem an eine schallundurchl&auml;ssige Wand angrenzt. Ferner wird in der Modellbildung davon ausgegangen, dass die L&ouml;cher in den Platten im submillimetrischen Bereich liegen. 

## Modellbildung

Die Berechnung beruht auf dem Modell von Atalla und Sgard [1] in Kombination mit einer vereinfachten Variante der Transfermatrixmethode. Dieses kombinierte Modell wurde in der Dissertation von Fackler [2] entwickelt und erprobt.

## Prinzipielle Benutzung der Simulationsmaske

Die vorliegende Simulationsmaske erlaubt dem Anwender die vier Gruppen von Konstruktionsparametern zu variieren:
Plattendicke, Lochradius, Por&ouml;sit&auml;t und Kavernendicke. F&uuml;r jede Gruppe sind je drei Parameter vorhanden, insgesamt
kann der Anwender also 12 Parameter ver&auml;ndern. F&uuml;r jeden Parameter sind Ober- und Untergrenzen festgelegt, um die 
Modellbildung und -berechnung in einem stabilen Wertebereich zu halten. Die drei Grafiken werden bei Ver&auml;nderung der Werte 
sofort aktualisiert. Alle Angaben sind in Metern. 

## Absorptionsfenster

F&uuml;r das Design und die Planung geeigneter Absorptionssysteme ist die Vorgabe eines 
Absorptionsfensters ausschlaggebend. Die 12 Parameter sind dann so zu w&auml;hlen, dass die sich ergebende Absorptionskennlinie stets 
oberhalb des Absorptionsfensters liegt. Das Fenster kann innerhalb fest vorgegebener oberer und unterer Schranken vom Anwender 
frei eingestellt werden.

## Funktionen zum Herunterladen von Daten

Alle drei Grafiken k&ouml;nnen mit der daf&uuml;r vorgesehenen Schaltfl&auml;che als pdf-Datei heruntergeladen werden. Ferner besteht
die M&ouml;glichkeit alle Werte der Simulationsmaske, inkl. die errechneten Funktionswerte der Absorptionskennlinie, als Excel-Datei
herunterzuladen.

## 3D-Ansicht

Auf dem separaten Reiter "Akustiksystem - 3D Ansicht" kann der Anwender eine 3D-Ansicht des Systems aufrufen.

## Optimierung

Nach Vorgabe eines Absorptionsfensters kann es f&uuml;r den Anwender sehr aufw&auml;ndig und zeitraubend sein, unter den 12 
einstellbaren Parametern eine Konfiguration zu finden, die die Absorptionsvorgaben erf&uuml;llt. Unter dem Reiter 
"Akustiksystem - Optimierung" findet der Anwender eine Funktion, die er &uuml;ber eine Schaltfl&auml;che starten kann und die 
ihm eine Wertkonfiguration errechnet, die den Absorptionsvorgaben gerecht wird.


## Literatur

[1] Atalla, Noureddine und Sgard, Franck. "Modeling of perforated plates and screens using rigid frame porous models." Journal of sound and vibration 303.1-2 (2007): 195-208.

[2] Fackler, Cameron Jeff. "Bayesian model selection for analysis and design of multilayer sound absorbers." (2014).
