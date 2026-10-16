**Aufgabe:Wende die Binomialverteilung auf ein eigenes Fertigungsszenario an:
  *1.Nimm eine Ausschussquote p = 0.05 und eine Stichprobe von n = 20 Teilen. Berechne mit dbinom die Wahrscheinlichkeit für 0, 1, 2 und 3 defekte Teile.
    dbinom(0, size=20, prob = 0.05)
    dbinom(1, size=20, prob = 0.05)
    dbinom(2, size=20, prob = 0.05)
    dbinom(3, size=20, prob = 0.05)
  *2.Zeichne die ganze Verteilung mit barplot(dbinom(0:20, 20, 0.05)) und beschreibe die Form in einem Satz.
    barplot(dbinom(0:20, 20, 0.05))
    A:Die Grafik zeigt eine rechtsschiefe Binomialverteilung mit einer sehr geringen Erfolgswahrscheinlichkeit, bei der die höchsten Wahrscheinlichkeiten ganz links liegen und nach rechts hin schnell gegen Null abfallen.
  *3.Erklärung: Warum ist (0 über 0) = 1? Argumentiere über die Anzahl der Wege.
    A:Der Binomialkoeffizient (0 über 0) ist gleich 1, weil es genau einen einzigen Weg gibt, von einem Startpunkt aus 0 Schritte zu gehen.